class Player < ActiveRecord::Base
  belongs_to :game, :inverse_of => :players
  belongs_to :user
  has_many :cards, :inverse_of => :player, :autosave => true

  include ChipOwner

  validates_presence_of :game, :user
  validates_uniqueness_of :user_id, :scope => :game_id
  
  validates :turn_num, :presence => true, :inclusion => { :in => 1.upto(4) }

  validates :turn_status, :presence => true, 
            :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}

  def played_cards
    cards.where(:is_reserved => false)
  end

  def reserved_cards
    cards.where(:is_reserved => true)
  end
end
