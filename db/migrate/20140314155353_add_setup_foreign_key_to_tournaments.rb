class AddSetupForeignKeyToTournaments < ActiveRecord::Migration
  def change
		add_column :tournaments, :setup_id, :integer
  end
end
