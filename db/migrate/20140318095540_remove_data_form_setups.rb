class RemoveDataFormSetups < ActiveRecord::Migration
  def change
		remove_column :setups, :data
  end
end
