class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :group_name
      t.string :venue_name
      t.datetime :time
      t.string :meetup_url

      t.timestamps
    end
  end
end
