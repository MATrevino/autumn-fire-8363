require 'rails_helper'

RSpec.describe PlantPlot, type: :model do
  it { should belong_to(:plot) }
  it { should belong_to(:plant) }
end
