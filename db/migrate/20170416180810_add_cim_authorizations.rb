class AddCimAuthorizations < ActiveRecord::Migration[5.0]
  def change
     create_table :cim_authorizations do |t|
       t.integer :user_id
       t.integer :cim_id
     end
  end
end
