class AddOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :url
    end
    add_index(:organizations, :name)
    add_index(:organizations, :url)
    CSV.foreach('db/organizations.csv').with_index do |row,i|
      next if i == 0
      Organization.create!( name: row[0] , url: row[1].gsub('-', ''))
    end
  end
end
