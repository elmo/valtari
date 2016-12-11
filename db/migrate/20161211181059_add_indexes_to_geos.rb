class AddIndexesToGeos < ActiveRecord::Migration[5.0]
  def change
    add_index(:geos, :division1)
    add_index(:geos, :division2)
    add_index(:geos, :division3)
    add_index(:geos, :division4)
    add_index(:geos, :division5)
  end
end
