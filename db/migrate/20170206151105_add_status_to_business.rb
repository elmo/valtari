class AddStatusToBusiness < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :duplication_status, :string
    add_column :businesses, :last_updated_by_id, :integer
    add_index(:businesses, :duplication_status)
    Business.update_all(duplication_status: "ready")
  end
end
