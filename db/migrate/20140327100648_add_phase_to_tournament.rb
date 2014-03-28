class AddPhaseToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :phase, :string
  end
end
