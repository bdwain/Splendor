module ChipCollection
  class ChipCollection
    attr_accessor :blue, :red, :green, :black, :white, :gold

    def initialize(obj)
      @blue = 0
      @red = 0
      @green = 0
      @black = 0
      @white = 0
      @gold = 0
      if obj.is_a?(Array)
        init_from_string_array(obj)
      elsif obj.is_a?(Card)
        init_from_card(obj)
      end
    end

    def count
      blue + red + green + black + white + gold
    end

    private
    def init_from_string_array(chips)
      chips.each do |chip|
        case chip.downcase
        when 'blue'
          @blue += 1
        when 'red'
          @red += 1
        when 'green'
          @green += 1
        when 'black'
          @black += 1
        when 'white'
          @white += 1
        when 'gold'
          @gold += 1
        else
          raise 'Invalid chip list'
        end
      end
    end

    def init_from_card(card)
      @blue += card.blue_cost
      @red += card.red_cost
      @green += card.green_cost
      @white += card.white_cost
      @black += card.black_cost
    end
  end
end