class Game < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
  belongs_to :winner, :class_name => 'User', :foreign_key => 'winner_id'

  has_many :players, :inverse_of => :game, :autosave => true, :dependent => :destroy
  has_many :cards, :inverse_of => :game, :autosave => true, :dependent => :destroy

  def current_player
    players.find{|p| p.turn_status != 0}
  end

  private
  STATUS_WAITING_FOR_PLAYERS = 1
  STATUS_PLAYING = 2
  STATUS_COMPLETED = 3

  public
  validates_presence_of :creator

  validates :status, :presence => true, 
            :inclusion => { :in => [STATUS_WAITING_FOR_PLAYERS, 
             STATUS_PLAYING, STATUS_COMPLETED] }

  validates :num_players, :presence => true, :inclusion => { :in => 2.upto(4), :message => " should be 2 3 or 4" }

  validates :turn_num, :presence => true, 
            :numericality => {:only_integer => true, :greater_than => 0}

  validates :blue_chips, :turn_num, :presence => true, :inclusion => { :in => 0.upto(7) },
            :numericality => {:only_integer => true}
  validates :red_chips, :turn_num, :presence => true, :inclusion => { :in => 0.upto(7) },
            :numericality => {:only_integer => true}
  validates :green_chips, :turn_num, :presence => true, :inclusion => { :in => 0.upto(7) },
            :numericality => {:only_integer => true}
  validates :black_chips, :turn_num, :presence => true, :inclusion => { :in => 0.upto(7) },
            :numericality => {:only_integer => true}
  validates :white_chips, :turn_num, :presence => true, :inclusion => { :in => 0.upto(7) },
            :numericality => {:only_integer => true}
  validates :gold_chips, :turn_num, :presence => true, :inclusion => { :in => 0.upto(5) },
            :numericality => {:only_integer => true}

  def waiting_for_players?
    status == STATUS_WAITING_FOR_PLAYERS
  end

  def playing?
    status == STATUS_PLAYING
  end

  def completed?
    status == STATUS_COMPLETED
  end

  def sorted_players
    @sorted_players ||= players.sort{|p1, p2| p1.turn_num <=> p2.turn_num}
  end

  #returns the player for a corresponding user, or nil if they aren't playing
  #Since this works for anything with an id, and id's are not guaranteed to be unique 
  #across different types of items, would it make sense to use email address?
  def player(user)
    players.detect { |p| p.user_id == user.id } if user != nil
  end

  def player?(user)
    player(user) != nil
  end  

  #this allows us to roll back game creation if the player fails to be added for the
  #creator. this would be an unexpected error, but at least no one will ever be left
  #wondering why they're not in the game they just created when they normally are
  after_create :after_create_add_creators_player
  def after_create_add_creators_player
    raise ActiveRecord::Rollback unless add_user?(creator)
  end

  def add_user?(user)
    if user != nil && user.confirmed? && waiting_for_players? && !player?(user) 
      player = players.build
      player.user = user
      save
    end
  end

  def remove_player?(player)
    if waiting_for_players? && player != nil && players.find_by_id(player.id) != nil
      #the size check is a fallback if the creator somehow leaves 
      #without deleting the game. It's just to avoid old empty games
      if player.user == creator || players.size == 1
        destroy
      else
        player.destroy
      end
    end
  end

  #when saving a game, initialize it for play if it's full but status is still waiting
  after_save do
    if num_players == players.length && waiting_for_players?
      raise ActiveRecord::Rollback unless init_game?
    end
    true
  end

  private
  def init_game?
    #give each player their own turn
    players.shuffle.each_with_index do |player, index|
      player.turn_num = index + 1
      player.turn_status = (index == 0 ? TAKING_TURN : WAITING_FOR_TURN)
      player.blue_chips = 0
      player.red_chips = 0
      player.green_chips = 0
      player.white_chips = 0
      player.black_chips = 0
      player.gold_chips = 0
    end

    default_chip_count = num_players == 4 ? 7 : (num_players == 3 ? 5 : 4)
    self.blue_chips = default_chip_count
    self.red_chips = default_chip_count
    self.green_chips = default_chip_count
    self.white_chips = default_chip_count
    self.black_chips = default_chip_count
    self.gold_chips = 5

    #create deck (use a file with the actual card list later. this is temporary)
    [BLUE, GREEN, RED, BLACK, WHITE].each do |color|
      (1..3).each do |level|
        4.times{ cards.build(color: COLOR, level: level, victory_points: (level - 1)*2, blue_cost: color == BLUE ? 0 : level, 
          red_cost: color == RED ? 0 : level, green_cost: color == GREEN ? 0 : level, black_cost: color == BLACK ? 0 : level, 
          white_cost: color == WHITE ? 0 : level)}
      end
    end

    #shuffle cards
    (1..3).each do |level|
      cur_cards = cards.select {|card| card.level == level}.shuffle
      cur_cards.last(cur_cards.length - 4).each_with_index { |card, index| card.position = index + 1 }
    end

    #noble_count = num_players + 1
    #init nobles

    self.status = STATUS_PLAYING
    save
  end
end
