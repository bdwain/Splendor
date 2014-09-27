module ChipCollection
  class ChipCollection
    attr_reader :blue, :red, :green, :black, :white, :gold

    def initialize(chips)
      @blue = 0
      @red = 0
      @green = 0
      @black = 0
      @white = 0
      @gold = 0
      if chips
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
    end

    def count
      @count ||= blue + red + green + black + white + gold
    end
  end
end