class AddImageToEvent < ActiveRecord::Migration[5.0]
  def change
     add_column :events, :photo, :integer
  end
end
