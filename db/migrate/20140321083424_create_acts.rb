class CreateActs < ActiveRecord::Migration
  def change
    create_table :acts do |t|
      t.integer :user_id
      t.integer :battle_id

      t.timestamps
    end
  end
end
