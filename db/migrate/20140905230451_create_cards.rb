class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.references :game, :null => false
      t.references :player, :null => true
      t.integer :position, :null => true, :default => 0
      t.integer :level, :null => false, :default => 1
      t.integer :color, :null => false, :default => 0
      t.boolean :is_reserved, :null => false, :default => false
      t.integer :victory_points, :null => false, :default => 0
      t.integer :blue_cost, :null => false, :default => 0
      t.integer :red_cost, :null => false, :default => 0
      t.integer :green_cost, :null => false, :default => 0
      t.integer :black_cost, :null => false, :default => 0
      t.integer :white_cost, :null => false, :default => 0
    end
  end
end
