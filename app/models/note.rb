class Note < ActiveRecord::Base
  belongs_to :owner, class_name: :user
  belongs_to :about, class_name: 'MeetupProfile'
end
