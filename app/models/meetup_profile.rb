class MeetupProfile < ActiveRecord::Base
  has_many :attendances
end
