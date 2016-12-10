class AddStateAbbreviationToGeos < ActiveRecord::Migration[5.0]
  def change
    add_column :geos, :state_abbreviation, :string
    Geo.state_abbrev_map.values.each do |state|
      abbreviation = Geo::state_abbrev_map.invert[state]
      Geo.where(division4: state).update_all(state_abbreviation: abbreviation)
    end
  end
end
