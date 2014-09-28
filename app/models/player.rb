class Player < ActiveRecord::Base
  belongs_to :game, :inverse_of => :players
  belongs_to :user
  has_many :cards, :inverse_of => :player, :autosave => true
  has_many :nobles, :inverse_of => :player, :autosave => true

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

  def can_buy_card?(card, spent)
    cost = ChipCollection.new(card)

    cost.blue -= num_cards_of_color(BLUE)
    cost.red -= num_cards_of_color(RED)
    cost.green -= num_cards_of_color(GREEN)
    cost.black -= num_cards_of_color(BLACK)
    cost.white -= num_cards_of_color(WHITE)

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

    return golds_left == 0
  end

  def victory_points
    card_points = played_cards.inject(0){|sum,card| sum += card.victory_points}
    nobles.inject(card_points){|sum, noble| sum += noble.victory_points}
  end

  def can_afford_noble?(noble)
    num_cards_of_color(BLUE) >= noble.blue_card_cost &&
    num_cards_of_color(RED) >= noble.red_card_cost &&
    num_cards_of_color(GREEN) >= noble.green_card_cost &&
    num_cards_of_color(BLACK) >= noble.black_card_cost &&
    num_cards_of_color(WHITE) >= noble.white_card_cost
  end

  private
  def num_cards_of_color(color)
    played_cards.select{|card| card.color == color}.size
  end
end
