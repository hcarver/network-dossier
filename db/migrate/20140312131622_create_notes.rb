class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :owner_id
      t.integer :about_id
      t.text :note_text, limit: nil

      t.timestamps
    end

    add_index :notes, [:owner_id, :about_id], unique: true
  end
end
