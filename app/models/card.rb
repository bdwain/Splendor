class Card < ActiveRecord::Base
  belongs_to :game, :inverse_of => :cards
  belongs_to :player, :inverse_of => :cards

  validates_presence_of :game

  validates_numericality_of :position, :only_integer => true

  validates :victory_points, :presence => true, 
            :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}

  validates :color, :presence => true, 
            :inclusion => { :in => [BLUE, RED, GREEN, BLACK, WHITE] }

  validates :level, :presence => true, :inclusion => { :in => 1.upto(3) }
  
  validates :blue_cost, :presence => true, 
            :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :red_cost, :presence => true, 
            :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :green_cost, :presence => true, 
            :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :black_cost, :presence => true, 
            :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :white_cost, :presence => true, 
            :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
end