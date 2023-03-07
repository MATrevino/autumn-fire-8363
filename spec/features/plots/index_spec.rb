require 'rails_helper'

RSpec.describe 'Plots Index Page' do
  let!(:garden) { Garden.create!(name: 'Turing Community Garden', organic: true) }
  
  let!(:plot1) { garden.plots.create!(number: 1, size: 'Large', direction: 'East') }
  let!(:plot2) { garden.plots.create!(number: 2, size: 'Medium', direction: 'West') }
  let!(:plot3) { garden.plots.create!(number: 3, size: 'Small', direction: 'North') }

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
  end
  describe 'as a visitor to /plots' do
    
    it 'I see a list of all the plot numbers, and under each, the names of all that plots plants' do
      visit '/plots'

      within("#plot-#{plot1.id}") do
        expect(page).to have_content("Plot number: #{plot1.number}")
        expect(page).to have_content(plant1.name)
        expect(page).to have_content(plant2.name)
        expect(page).to have_content(plant3.name)
      end

      within("#plot-#{plot2.id}") do
        expect(page).to have_content("Plot number: #{plot2.number}")
        expect(page).to have_content(plant1.name)
        expect(page).to have_content(plant2.name)

        expect(page).to_not have_content(plant3.name)
      end

      within("#plot-#{plot3.id}") do
        expect(page).to have_content("Plot number: #{plot3.number}")
        expect(page).to have_content(plant3.name)

        expect(page).to_not have_content(plant1.name)
        expect(page).to_not have_content(plant2.name)
      end
    end

    describe "next to seach plant name is a link to remove that plant from that plot" do
      it 'when I click link, i am redirected back to plots index page and no longer see that plant listed under that plot but still see it under other plots assoicated with it' do
        visit '/plots'
        within("#plot-#{plot1.id}") do
          expect(page).to have_link("Remove #{plant1.name}")

          click_link("Remove #{plant1.name}")

          expect(current_path).to eq('/plots')
          expect(page).to_not have_content(plant1.name)
        end

        within("#plot-#{plot2.id}") do
          expect(page).to have_content(plant1.name)
        end
      end
    end
  end
end