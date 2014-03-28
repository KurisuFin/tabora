class DropSetup < ActiveRecord::Migration
  def change
		drop_table :setups
  end
end
