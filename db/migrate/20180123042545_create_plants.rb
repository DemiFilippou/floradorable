class CreatePlants < ActiveRecord::Migration[5.1]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :scientific_name
      t.string :light_indoors
      t.string :light_outdoors
      t.string :water
      t.string :potting

      t.timestamps
    end
  end
end
