class UserPlant < ApplicationRecord
  belongs_to :user
  belongs_to :plant

  # enums
  enum pot_size: [ xs: 1, small: 2, medium: 3, large: 4, none: 5 ]

  # callbacks
  before_update :create_schedule, :if => :pot_size_changed?
  before_create :create_schedule

  def create_schedule
    # pot size #
    pot_size_num = UserPlant.pot_sizes[self.pot_size]
    water_num = Plant.waters[self.plant.water]

    # exponential growth: water_frequency = 2(1 - 0.15)^x
    # x = # representing pot size * # representing water needs
    water_frequency = (2 * (0.85^(pot_size_num *  water_num))).round
    self.update(water_frequency: water_frequency)
  end
end
