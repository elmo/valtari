class CreateBusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :businesses do |t|
      t.string :company_name
      t.string :contact_first_name
      t.string :contact_last_name
      t.string :contact_title
      t.string :phone
      t.string :email
      t.string :website
      t.integer :revenue
      t.integer :number_of_employees
      t.string :naics_code
      t.string :sic_code
      t.string :industry_classification
      t.text :description
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code
      t.string :status
      t.timestamps
      t.index :status
      t.index :country
      t.index :naics_code
      t.index :sic_code
    end
  end
end
