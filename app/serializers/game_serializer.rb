class GameSerializer < ActiveModel::Serializer
  attributes :id, :status, :num_players, :blue_chips, :red_chips, :green_chips, 
             :black_chips, :white_chips, :gold_chips, :turn_num, 
             :level_1_card_count, :level_2_card_count, :level_3_card_count
  has_one :winner, :creator
  has_many :players, :cards, :nobles

  def cards
    object.cards.select{|card| card.position == 0}
  end

  def status
    if object.waiting_for_players?
      "waiting_for_players"
    elsif object.playing?
      "playing"
    elsif object.last_turn?
      "last_turn"
    else
      "completed"
    end
  end

  def level_1_card_count
    level_n_card_count(1)
  end

  def level_2_card_count
    level_n_card_count(2)
  end

  def level_3_card_count
    level_n_card_count(3)
  end

  def nobles
    object.nobles.where(player: nil)
  end

  private
  def level_n_card_count(level)
    object.cards.select{|card| card.position > 0 && card.level == level}.size
  end
end