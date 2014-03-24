class CreateBattleConnections < ActiveRecord::Migration
  def change
    create_table :battle_connections, id: false do |t|
      t.integer :battle_id
      t.integer :postbattle_id
    end
  end
end
