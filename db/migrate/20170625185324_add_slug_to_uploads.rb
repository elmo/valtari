class AddSlugToUploads < ActiveRecord::Migration[5.0]
  def change
    add_column :deal_room_uploads, :slug, :string
    add_index :deal_room_uploads, :slug
  end
end
