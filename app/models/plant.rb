class Plant < ApplicationRecord
  has_many :user_plants

  attribute [:light_outdoors, :light_indoors, :potting]
  # enums
  as_enum :light_indoors, [ :low, :medium, :high ], accessor: :join_table
  as_enum :light_outdoors, [ :shade, :part_sun, :sun ], accessor: :join_table
  enum water: { low: 1, medium: 1.5, high: 2 } # high = keep moist
  enum potting: [ :soil, :peat_moss, :vermiculite, :pine_bark ]
end
