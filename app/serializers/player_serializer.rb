class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :turn_num, :turn_status, :turn_deadline, :blue_chips, :red_chips,
   :green_chips, :black_chips, :white_chips, :gold_chips, :victory_points,
   :played_cards, :reserved_card_count, :reserved_cards

  has_one :user

  def reserved_cards
    ActiveModel::ArraySerializer.new(object.reserved_cards, each_serializer: CardSerializer)
  end

  def played_cards
    ActiveModel::ArraySerializer.new(object.played_cards, each_serializer: CardSerializer)
  end

  def reserved_card_count
    object.reserved_cards.size
  end

  def filter(keys)
    keys.delete(:reserved_cards) if user != scope
    keys
  end
end