class GameSerializer < ActiveModel::Serializer
  attributes :id, :status, :num_players, :blue_chips, :red_chips, :green_chips, 
             :black_chips, :white_chips, :gold_chips, :turn_num
  has_one :winner, :creator
  has_many :players
end