class AddVerificationStatusToBusiness < ActiveRecord::Migration[5.0]
  def change
    add_column(:businesses, :verification_status, :string)
    add_index(:businesses, :verification_status)
  end
end
