class CreateUserPlants < ActiveRecord::Migration[5.1]
  def change
    create_table :user_plants do |t|
      t.string :pot_size
      t.datetime :last_watered
      t.integer :water_frequency
      t.string :image
      t.boolean :indoors
      t.integer :plant_id
      t.belongs_to :plant
      t.belongs_to :user

      t.timestamps
    end
  end
end
