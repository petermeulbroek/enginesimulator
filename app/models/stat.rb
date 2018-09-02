class Stat < ApplicationRecord

  # validations
  validates_presence_of :time, :value

end
