class AddCompanyNameToDealRoom < ActiveRecord::Migration[5.0]
  def change
    add_column :deal_rooms, :company_name, :string
  end
end
