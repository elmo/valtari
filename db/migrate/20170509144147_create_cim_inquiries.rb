class CreateCimInquiries < ActiveRecord::Migration[5.0]
  def change
    create_table :cim_inquiries do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :company
      t.text :comment

      t.timestamps
    end
  end
end
