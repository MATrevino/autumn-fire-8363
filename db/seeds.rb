# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
garden1 = Garden.create!(name: 'Turing Community Garden', organic: true)
garden2 = Garden.create!(name: 'Baker Community Garden', organic: false)

plot1 = garden1.plots.create!(number: 1, size: 'Large', direction: 'East')
plot2 = garden1.plots.create!(number: 2, size: 'Medium', direction: 'West')
plot3 = garden1.plots.create!(number: 3, size: 'Small', direction: 'North')
plot4 = garden2.plots.create!(number: 4, size: 'Small', direction: 'South')

plant1 = Plant.create!(name: 'Lavender', description: 'Herb', days_to_harvest: 90)
plant2 = Plant.create!(name: 'Rosemary', description: 'Herb', days_to_harvest: 100)
plant3 = Plant.create!(name: 'Tomato', description: 'Vegetable', days_to_harvest: 70)


  PlantPlot.create!(plant: plant1, plot: plot1)
  PlantPlot.create!(plant: plant2, plot: plot1)
  PlantPlot.create!(plant: plant3, plot: plot1)

  PlantPlot.create!(plant: plant1, plot: plot2)
  PlantPlot.create!(plant: plant2, plot: plot2)

  PlantPlot.create!(plant: plant3, plot: plot3)
  
  PlantPlot.create!(plant: plant1, plot: plot4)
