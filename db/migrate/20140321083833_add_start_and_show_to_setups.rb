class AddStartAndShowToSetups < ActiveRecord::Migration
  def change
    add_column :setups, :start, :text
    add_column :setups, :show, :text
  end
end
