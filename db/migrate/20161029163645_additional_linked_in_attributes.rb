class AdditionalLinkedInAttributes < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :industry, :string
    add_column :users, :headline, :string
    add_column :users, :location, :string
    add_column :users, :picture_url, :string
    add_column :users, :profile_url, :string
  end
end
