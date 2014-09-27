class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :turn_num, :turn_status, :turn_deadline, :blue_chips, :red_chips,
   :green_chips, :black_chips, :white_chips, :gold_chips,
   :played_cards, :reserved_card_count, :reserved_cards

  has_one :user
  delegate :current_user, to: :scope

  def reserved_card_count
    reserved_cards.size
  end

  def played_cards
    object.cards.where(:is_reserved => false)
  end

  def reserved_cards
    object.cards.where(:is_reserved => true)
  end

  def filter(keys)
    keys.delete(:reserved_cards) if user != scope
    keys
  end
end