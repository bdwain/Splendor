class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :num_players, :null => false
      t.integer :status, :null => false, :default => 1
      t.integer :creator_id, :null => false
      t.integer :winner_id, :null => true
      t.integer :blue_chips, :null => false, :default => 0
      t.integer :red_chips, :null => false, :default => 0
      t.integer :green_chips, :null => false, :default => 0
      t.integer :black_chips, :null => false, :default => 0
      t.integer :white_chips, :null => false, :default => 0
      t.integer :gold_chips, :null => false, :default => 0
      t.integer :turn_num, :null => false, :default => 1

      t.timestamps
    end
    add_index :games, :creator_id
    add_index :games, :winner_id
  end
end
