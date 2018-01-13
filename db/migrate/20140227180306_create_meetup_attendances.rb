class CreateMeetupAttendances < ActiveRecord::Migration
  def change
    create_join_table(:meetup_profiles, :events, table_name: "attendances") do |t|
      t.index :meetup_profile_id
      t.index :event_id
    end
    add_index :attendances, [:meetup_profile_id, :event_id], unique: true
  end
end
