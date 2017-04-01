class CreateVerifications < ActiveRecord::Migration[5.0]
  def change

    create_table :verifications do |t|
      t.integer :user_id
      t.integer :assigned_to_user_id
      t.integer :business_id
      t.string :status
      t.timestamps
    end

    add_index(:verifications, :user_id)
    add_index(:verifications, :business_id)
    add_index(:verifications, :assigned_to_user_id)
    add_index(:verifications, :status)

    add_column(:businesses, :last_verified_by, :integer)
    add_column(:businesses, :last_verified, :datetime)

  end

end
