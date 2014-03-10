class CreateOperators < ActiveRecord::Migration
  def change
    create_table :operators do |t|
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
  end
end
