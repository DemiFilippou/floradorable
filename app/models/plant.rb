class Plant < ApplicationRecord
  has_many :user_plants

  # enums
  enum light_indoors: [ :low, :medium, :high ]
  enum light_outoors: [ :shade, :part_sun, :sun ]
  enum water: [ low: 1, medium: 1.5, high: 2 ] # high = keep moist
  enum potting: [ :soil, :peat_moss, :vermiculite, :pine_bark ]

end
