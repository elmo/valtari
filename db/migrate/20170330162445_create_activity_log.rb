class CreateActivityLog < ActiveRecord::Migration[5.0]
  def change
    create_table :activity_logs do |t|
       t.integer :user_id
       t.integer :business_id
       t.string :action
       t.timestamps
    end
  end
end
