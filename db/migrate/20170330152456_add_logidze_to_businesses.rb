class AddLogidzeToBusinesses < ActiveRecord::Migration
  require 'logidze/migration'
  include Logidze::Migration

  def up
    
    add_column :businesses, :log_data, :jsonb
    

    execute <<-SQL
      CREATE TRIGGER logidze_on_businesses
      BEFORE UPDATE OR INSERT ON businesses FOR EACH ROW
      WHEN (coalesce(#{current_setting('logidze.disabled')}, '') <> 'on')
      EXECUTE PROCEDURE logidze_logger(null, 'updated_at');
    SQL

    
  end

  def down
    execute "DROP TRIGGER IF EXISTS logidze_on_businesses on businesses;"

    
    remove_column :businesses, :log_data
    
  end
end
