class CreateNobles < ActiveRecord::Migration
  def change
    create_table :nobles do |t|
      t.references :game, :null => false
      t.references :player, :null => true
      t.integer :blue_card_cost, :null => false, :default => 0
      t.integer :red_card_cost, :null => false, :default => 0
      t.integer :green_card_cost, :null => false, :default => 0
      t.integer :black_card_cost, :null => false, :default => 0
      t.integer :white_card_cost, :null => false, :default => 0
    end
  end
end
