class AddOpenedAtToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :opened_at, :datetime
  end
end
