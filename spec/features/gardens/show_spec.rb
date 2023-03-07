require 'rails_helper'

RSpec.describe 'Gardens show Page' do
  let!(:garden1) { Garden.create!(name: 'Turing Community Garden', organic: true) }
  let!(:garden2) { Garden.create!(name: 'Baker Community Garden', organic: false) }
  
  let!(:plot1) { garden1.plots.create!(number: 1, size: 'Large', direction: 'East') }
  let!(:plot2) { garden1.plots.create!(number: 2, size: 'Medium', direction: 'West') }
  let!(:plot3) { garden1.plots.create!(number: 3, size: 'Small', direction: 'North') }
  let!(:plot4) { garden2.plots.create!(number: 4, size: 'Small', direction: 'South') }

  let!(:plant1) { Plant.create!(name: 'Lavender', description: 'Herb', days_to_harvest: 90) }
  let!(:plant2) { Plant.create!(name: 'Rosemary', description: 'Herb', days_to_harvest: 100) }
  let!(:plant3) { Plant.create!(name: 'Tomato', description: 'Vegetable', days_to_harvest: 70) }

  before do
    PlantPlot.create!(plant: plant1, plot: plot1)
    PlantPlot.create!(plant: plant2, plot: plot1)
    PlantPlot.create!(plant: plant3, plot: plot1)

    PlantPlot.create!(plant: plant1, plot: plot2)
    PlantPlot.create!(plant: plant2, plot: plot2)

    PlantPlot.create!(plant: plant3, plot: plot3)

    PlantPlot.create!(plant: plant1, plot: plot4)
  end
  
  describe 'as a visitor to /gardens/:id' do
    it 'I see a list of plants that are included in that gardens plots (unique), and list only contains plants that take less tahn 100 days to harvest' do
      visit "/gardens/#{garden1.id}"
      
      expect(page).to have_content("Plants in #{garden1.name}")
      expect(page).to have_content(plant1.name).once
      expect(page).to have_content(plant3.name).once

      expect(page).to_not have_content(plant2.name)
    end
  end
end
