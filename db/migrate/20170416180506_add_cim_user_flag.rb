class AddCimUserFlag < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :cim, :boolean, default: false
  end
end
