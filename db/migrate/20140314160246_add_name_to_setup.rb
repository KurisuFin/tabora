class AddNameToSetup < ActiveRecord::Migration
  def change
    add_column :setups, :name, :string
  end
end
