class CreateSetups < ActiveRecord::Migration
  def change
    create_table :setups do |t|
      t.text :code
      t.text :data

      t.timestamps
    end
  end
end
