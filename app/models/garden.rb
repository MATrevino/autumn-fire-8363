class Garden < ApplicationRecord
  has_many :plots
  has_many :plant_plots, through: :plots
  has_many :plants, through: :plant_plots

  def unique_plants_under_100_harvest
    plants.where('days_to_harvest < 100').distinct
  end
end
