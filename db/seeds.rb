# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

garden_1 = Garden.create(name: "Backyard Garden", user_id: 1, state_code: "CO", zip_code: "80223")

nw = garden_1.plots.create(name: "Native Wildflowers")
s = garden_1.plots.create(name: "Shrubs")
og = garden_1.plots.create(name: "Foxtails")

# plant_ids: [692, 869, 876]
# plant_ids: [206, 360]
# plant_ids: [57, 58, 66]

nw.update!(plant_ids: [692, 869, 876])
s.update!(plant_ids:[206, 360])
og.update!(plant_ids: [57, 58, 66])




