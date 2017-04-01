class AddCompletedByUser < ActiveRecord::Migration[5.0]
  def change
     add_column :verifications, :completed_by_user_id, :integer
  end
end
