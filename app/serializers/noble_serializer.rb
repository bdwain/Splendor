class NobleSerializer < ActiveModel::Serializer
  attributes :id, :victory_points, :blue_card_cost, :red_card_cost, 
  :green_card_cost, :black_card_cost, :white_card_cost
end