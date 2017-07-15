class AddLicenses < ActiveRecord::Migration[5.0]
  def change
    create_table :licenses do |t|
       t.integer :user_id
       t.integer :maximum_number_of_users
       t.timestamps
    end
  end
end
