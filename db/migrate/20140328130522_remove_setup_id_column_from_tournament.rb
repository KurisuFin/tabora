class RemoveSetupIdColumnFromTournament < ActiveRecord::Migration
  def change
		remove_column :tournaments, :setup_id
  end
end
