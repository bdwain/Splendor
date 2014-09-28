class Noble < ActiveRecord::Base
  belongs_to :game, :inverse_of => :nobles
  belongs_to :player, :inverse_of => :nobles

  validates_presence_of :game

  validates :victory_points, :presence => true, 
            :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :blue_card_cost, :presence => true, 
            :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :red_card_cost, :presence => true, 
            :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :green_card_cost, :presence => true, 
            :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :black_card_cost, :presence => true, 
            :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :white_card_cost, :presence => true, 
            :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
end