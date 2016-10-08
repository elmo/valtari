class AddIndexesToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_index(:businesses, :company_name)
    add_index(:businesses, :contact_last_name)
    add_index(:businesses, :phone)
    add_index(:businesses, :email)
    add_index(:businesses, :number_of_employees)
    add_index(:businesses, :industry_classification)
    add_index(:businesses, :city)
    add_index(:businesses, :state)
  end
end
