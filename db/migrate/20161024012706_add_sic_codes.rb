class AddSicCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :sic_codes do |t|
      t.string :code
      t.string :name
    end
    add_index(:sic_codes, :code)
    CSV.foreach('db/sic_codes.csv').with_index do |row,i|
      next if i == 0
      SicCode.create!( code: row[3] ,name: row[4])
    end
  end
end
