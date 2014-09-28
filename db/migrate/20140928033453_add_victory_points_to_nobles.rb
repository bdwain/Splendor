class AddVictoryPointsToNobles < ActiveRecord::Migration
  def change
    add_column :nobles, :victory_points, :integer
  end
end
