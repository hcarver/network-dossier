class CreateMeetupProfiles < ActiveRecord::Migration
  def change
    create_table :meetup_profiles do |t|
      t.timestamps

      t.string :name
      t.string :photo_url
      t.string :access_token
      t.string :refresh_token
      t.datetime :access_expiration
      t.string :other_services
    end
  end
end
