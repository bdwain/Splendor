module ChipOwner
  extend ActiveSupport::Concern

  included do
    validates :blue_chips, :turn_num, :presence => true, :inclusion => { :in => 0.upto(7), :message => "need to be from 0-7" }
    validates :red_chips, :turn_num, :presence => true, :inclusion => { :in => 0.upto(7), :message => "need to be from 0-7" }
    validates :green_chips, :turn_num, :presence => true, :inclusion => { :in => 0.upto(7), :message => "need to be from 0-7" }
    validates :black_chips, :turn_num, :presence => true, :inclusion => { :in => 0.upto(7), :message => "need to be from 0-7" }
    validates :white_chips, :turn_num, :presence => true, :inclusion => { :in => 0.upto(7), :message => "need to be from 0-7" }
    validates :gold_chips, :turn_num, :presence => true, :inclusion => { :in => 0.upto(5), :message => "need to be from 0-5" }

    def chip_count
      @chip_count ||= blue_chips + red_chips + green_chips + black_chips + white_chips + gold_chips
    end

    def subtract_chips(chip_collection)
      self.blue_chips -= chip_collection.blue
      self.red_chips -= chip_collection.red
      self.green_chips -= chip_collection.green
      self.black_chips -= chip_collection.black
      self.white_chips -= chip_collection.white
      self.gold_chips -= chip_collection.gold
    end

    def add_chips(chip_collection)
      self.blue_chips += chip_collection.blue
      self.red_chips += chip_collection.red
      self.green_chips += chip_collection.green
      self.black_chips += chip_collection.black
      self.white_chips += chip_collection.white
      self.gold_chips += chip_collection.gold
    end
  end
end