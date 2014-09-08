class Player < ActiveRecord::Base
  belongs_to :game, :inverse_of => :players
  belongs_to :user, :inverse_of => :players
  has_many :cards, :inverse_of => :game, :autosave => true

  validates_presence_of :game, :user
  validates_uniqueness_of :user_id, :scope => :game_id
  
  validates :turn_num, :presence => true, :inclusion => { :in => 1.upto(4) },
            :numericality => {:only_integer => true }

  validates :turn_status, :presence => true, 
            :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}

  validates :blue_chips, :presence => true, :inclusion => { :in => 0.upto(7) },
            :numericality => {:only_integer => true}
  validates :red_chips, :presence => true, :inclusion => { :in => 0.upto(7) },
            :numericality => {:only_integer => true}
  validates :green_chips, :presence => true, :inclusion => { :in => 0.upto(7) },
            :numericality => {:only_integer => true}
  validates :black_chips, :presence => true, :inclusion => { :in => 0.upto(7) },
            :numericality => {:only_integer => true}
  validates :white_chips, :presence => true, :inclusion => { :in => 0.upto(7) },
            :numericality => {:only_integer => true}
  validates :gold_chips, :presence => true, :inclusion => { :in => 0.upto(5) },
            :numericality => {:only_integer => true}
  
  def get_chip_count
    blue_chips + red_chips + green_chips + black_chips + white_chips + gold_chips
  end
end
