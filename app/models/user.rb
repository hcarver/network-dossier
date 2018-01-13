class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable, :recoverable, :validatable
  devise :omniauthable, :rememberable, :trackable, :database_authenticatable, :omniauth_providers => [:meetup]
  belongs_to :meetup_profile

  has_many :attendances, through: :meetup_profile
  has_many :events, through: :attendances
  has_many :notes, foreign_key: :owner_id
  has_many :noted, through: :notes, class_name: 'MeetupProfile', source: :about

  accepts_nested_attributes_for :notes
end
