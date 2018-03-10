class AddNicknameToUserPlants < ActiveRecord::Migration[5.1]
  def change
    add_column :user_plants, :nickname, :string
  end
end
