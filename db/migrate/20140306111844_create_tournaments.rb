class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.integer :event_id
      t.integer :game_id

      t.timestamps
    end
  end
end
