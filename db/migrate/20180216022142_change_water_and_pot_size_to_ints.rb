class ChangeWaterAndPotSizeToInts < ActiveRecord::Migration[5.1]
  def change
    change_column :plants, :water, :integer
    change_column :user_plants, :pot_size, :integer
  end
end
