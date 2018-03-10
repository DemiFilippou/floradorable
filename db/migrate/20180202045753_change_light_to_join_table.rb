class ChangeLightToJoinTable < ActiveRecord::Migration[5.1]
  def up 
    remove_column :plants, :light_indoors
    create_join_table :plants, :light_indoors
    remove_column :plants, :light_outdoors
    create_join_table :plants, :light_outdoors
  end

  def down
    drop_join_table :plants, :light_outdoors
    drop_join_table :plants, :light_indoors

    add_column :plants, :light_outdoors, :string
    add_column :plants, :light_indoors, :string
  end
end
