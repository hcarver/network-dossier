class Event < ActiveRecord::Base
  has_many :attendances
  has_many :meetup_profiles, through: :attendances
end
