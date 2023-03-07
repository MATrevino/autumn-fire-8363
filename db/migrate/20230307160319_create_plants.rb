class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :describe
      t.integer :days_to_harvest
      
      t.timestamps
    end
  end
end
