class AddDivisionsToBusiness < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :division1, :string
    add_column :businesses, :division2, :string
    add_column :businesses, :division3, :string
    add_column :businesses, :division4, :string
    add_column :businesses, :division5, :string
    add_index(:businesses, :division1)
    add_index(:businesses, :division2)
    add_index(:businesses, :division3)
    add_index(:businesses, :division4)
    add_index(:businesses, :division5)
  end
end
