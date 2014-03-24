class AddScoreToActs < ActiveRecord::Migration
  def change
    add_column :acts, :score, :integer
  end
end
