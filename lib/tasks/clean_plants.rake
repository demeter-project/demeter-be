require 'csv'

desc 'Clean incomplete data from native plants CSV'

task clean_plants: :environment do
  native_plants = Rails.root.join("db", "data", "native_plants.csv")
  native_plants_clean = Rails.root.join("db", "data", "native_plants_clean.csv")

  table = CSV.table(native_plants)

  table.delete_if do |row|
    attr = row[:temperature_minimum_f]
    attr.blank? || attr.nil? || attr == "NA"
  end

  File.open(native_plants_clean, 'w') do |f|
    f.write(table.to_csv)
  end
end
  