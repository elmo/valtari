class AddFilesToCims < ActiveRecord::Migration[5.0]
  def change
    add_column :cims, :html, :oid, null: false
    add_column :cims, :pdf, :oid, null: false
  end
end
