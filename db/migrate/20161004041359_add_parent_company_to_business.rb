class AddParentCompanyToBusiness < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :parent_company, :string
  end
end
