class CardSerializer < ActiveModel::Serializer
  attributes :id, :victory_points, :color, :level, :blue_cost, 
  :red_cost, :green_cost, :black_cost, :white_cost

  def color
    case object.color
    when BLUE
      "blue"
    when RED
      "red"
    when GREEN
      "green"
    when BLACK
      "black"
    when WHITE
      "white"
    end
  end
end