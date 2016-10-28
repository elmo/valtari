class AddIndustryClassifications < ActiveRecord::Migration[5.0]
  def change
    create_table :industry_classifications do |t|
      t.string :name
    end
    [
      'Biotechnology',
      'Business products and services',
      'Computers and peripherals',
      'Consumer products and services',
      'Electronics/instrumentation',
      'Financial services',
      'Healthcare services',
      'Industrial/energy',
      'IT services',
      'Media and entertainment',
      'Medical devices and equipment',
      'Networking and equipment',
      'Retailing/distribution',
      'Semiconductors',
      'Software',
      'Telecommunications'].each do |name|
        IndustryClassification.create(name: name)
      end
  end
end
