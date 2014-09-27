class Player < ActiveRecord::Base
  belongs_to :game, :inverse_of => :players
  belongs_to :user
  has_many :cards, :inverse_of => :player, :autosave => true

  include ChipOwner
  include ChipCollection

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

  def buy_card(card, spent)
    cost = ChipCollection.new(card)
    puts cost.inspect
    puts card.inspect
    puts spent.inspect
    cost.blue -= cards.select{|card| card.color == BLUE && !card.is_reserved}.size
    cost.red -= cards.select{|card| card.color == RED && !card.is_reserved}.size
    cost.green -= cards.select{|card| card.color == GREEN && !card.is_reserved}.size
    cost.black -= cards.select{|card| card.color == BLACK && !card.is_reserved}.size
    cost.white -= cards.select{|card| card.color == WHITE && !card.is_reserved}.size

    golds_left = spent.gold
    
    if cost.blue > 0
      cost.blue -= spent.blue
      if cost.blue > 0
        golds_left -= cost.blue
      end
    end

    if cost.red > 0
      cost.red -= spent.red
      if cost.red > 0
        golds_left -= cost.red
      end
    end

    if cost.green > 0
      cost.green -= spent.green
      if cost.green > 0
        golds_left -= cost.green
      end
    end

    if cost.black > 0
      cost.black -= spent.black
      if cost.black > 0
        golds_left -= cost.black
      end
    end

    if cost.white > 0
      cost.white -= spent.white
      if cost.white > 0
        golds_left -= cost.white
      end
    end

    raise "Can't buy the card with those chips" if golds_left != 0

    subtract_chips(spent)
    card.is_reserved = false
    card.position = -1
    card.player = self
  end
end
