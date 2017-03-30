class LogidzeInstall < ActiveRecord::Migration
  require 'logidze/migration'
  include Logidze::Migration

  def up
    unless current_setting_missing_supported?
      execute <<-SQL
        DO $$
          BEGIN
          EXECUTE 'ALTER DATABASE ' || quote_ident(current_database()) || ' SET logidze.disabled=' || quote_literal('');
          EXECUTE 'ALTER DATABASE ' || quote_ident(current_database()) || ' SET logidze.responsible=' || quote_literal('');
          END;
        $$
        LANGUAGE plpgsql;
      SQL
    end

    

    execute <<-SQL
      CREATE OR REPLACE FUNCTION logidze_version(v bigint, data jsonb, ts timestamp with time zone, blacklist text[] DEFAULT '{}') RETURNS jsonb AS $body$
        DECLARE
          buf jsonb;
        BEGIN
          buf := jsonb_build_object(
                   'ts',
                   (extract(epoch from ts) * 1000)::bigint,
                   'v',
                    v,
                    'c',
                    logidze_exclude_keys(data, VARIADIC array_append(blacklist, 'log_data'))
                   );
          IF coalesce(#{current_setting('logidze.responsible')}, '') <> '' THEN
            buf := jsonb_set(buf, ARRAY['r'], to_jsonb(current_setting('logidze.responsible')));
          END IF;
          RETURN buf;
        END;
      $body$
      LANGUAGE plpgsql;

      CREATE OR REPLACE FUNCTION logidze_snapshot(item jsonb, ts_column text, blacklist text[] DEFAULT '{}') RETURNS jsonb AS $body$
        DECLARE
          ts timestamp with time zone;
        BEGIN
          IF ts_column IS NULL THEN
            ts := statement_timestamp();
          ELSE
            ts := coalesce((item->>ts_column)::timestamp with time zone, statement_timestamp());
          END IF;
          return json_build_object(
            'v', 1,
            'h', jsonb_build_array(
                   logidze_version(1, item, ts, blacklist)
                 )
            );
        END;
      $body$
      LANGUAGE plpgsql;

      CREATE OR REPLACE FUNCTION logidze_exclude_keys(obj jsonb, VARIADIC keys text[]) RETURNS jsonb AS $body$
        DECLARE
          res jsonb;
          key text;
        BEGIN
          res := obj;
          FOREACH key IN ARRAY keys
          LOOP
            res := res - key;
          END LOOP;
          RETURN res;
        END;
      $body$
      LANGUAGE plpgsql;

      CREATE OR REPLACE FUNCTION logidze_compact_history(log_data jsonb) RETURNS jsonb AS $body$
        DECLARE
          merged jsonb;
        BEGIN
          merged := jsonb_build_object(
            'ts',
            log_data#>'{h,1,ts}',
            'v',
            log_data#>'{h,1,v}',
            'c',
            (log_data#>'{h,0,c}') || (log_data#>'{h,1,c}')
          );

          IF (log_data#>'{h,1}' ? 'r') THEN
            merged := jsonb_set(merged, ARRAY['r'], log_data#>'{h,1,r}');
          END IF;

          return jsonb_set(
            log_data,
            '{h}',
            jsonb_set(
              log_data->'h',
              '{1}',
              merged
            ) - 0
          );
        END;
      $body$
      LANGUAGE plpgsql;

      CREATE OR REPLACE FUNCTION logidze_logger() RETURNS TRIGGER AS $body$
        DECLARE
          changes jsonb;
          new_v integer;
          size integer;
          history_limit integer;
          current_version integer;
          merged jsonb;
          iterator integer;
          item record;
          columns_blacklist text[];
          ts timestamp with time zone;
          ts_column text;
        BEGIN
          ts_column := NULLIF(TG_ARGV[1], 'null');
          columns_blacklist := TG_ARGV[2];

          IF TG_OP = 'INSERT' THEN

            NEW.log_data := logidze_snapshot(to_jsonb(NEW.*), ts_column, columns_blacklist);

          ELSIF TG_OP = 'UPDATE' THEN

            IF OLD.log_data is NULL OR OLD.log_data = '{}'::jsonb THEN
              NEW.log_data := logidze_snapshot(to_jsonb(NEW.*), ts_column, columns_blacklist);
              RETURN NEW;
            END IF;

            history_limit := NULLIF(TG_ARGV[0], 'null');
            current_version := (NEW.log_data->>'v')::int;

            IF ts_column IS NULL THEN
              ts := statement_timestamp();
            ELSE
              ts := (to_jsonb(NEW.*)->>ts_column)::timestamp with time zone;
              IF ts IS NULL OR ts = (to_jsonb(OLD.*)->>ts_column)::timestamp with time zone THEN
                ts := statement_timestamp();
              END IF;
            END IF;

            IF NEW = OLD THEN
              RETURN NEW;
            END IF;

            IF current_version < (NEW.log_data#>>'{h,-1,v}')::int THEN
              iterator := 0;
              FOR item in SELECT * FROM jsonb_array_elements(NEW.log_data->'h')
              LOOP
                IF (item.value->>'v')::int > current_version THEN
                  NEW.log_data := jsonb_set(
                    NEW.log_data,
                    '{h}',
                    (NEW.log_data->'h') - iterator
                  );
                END IF;
                iterator := iterator + 1;
              END LOOP;
            END IF;

            changes := hstore_to_jsonb_loose(
              hstore(NEW.*) - hstore(OLD.*)
            );

            new_v := (NEW.log_data#>>'{h,-1,v}')::int + 1;

            size := jsonb_array_length(NEW.log_data->'h');

            NEW.log_data := jsonb_set(
              NEW.log_data,
              ARRAY['h', size::text],
              logidze_version(new_v, changes, ts, columns_blacklist),
              true
            );

            NEW.log_data := jsonb_set(
              NEW.log_data,
              '{v}',
              to_jsonb(new_v)
            );

            IF history_limit IS NOT NULL AND history_limit = size THEN
              NEW.log_data := logidze_compact_history(NEW.log_data);
            END IF;
          END IF;

          return NEW;
        END;
        $body$
        LANGUAGE plpgsql;
    SQL
  end

  def down
    
    execute <<-SQL
      DROP FUNCTION logidze_version(bigint, jsonb, timestamp with time zone, text[]) CASCADE;
      DROP FUNCTION logidze_compact_history(jsonb) CASCADE;
      DROP FUNCTION logidze_snapshot(jsonb, text, text[]) CASCADE;
      DROP FUNCTION logidze_logger() CASCADE;
    SQL
    
  end
end
