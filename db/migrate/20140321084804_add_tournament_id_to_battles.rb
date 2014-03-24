class AddTournamentIdToBattles < ActiveRecord::Migration
  def change
    add_column :battles, :tournament_id, :integer
  end
end
