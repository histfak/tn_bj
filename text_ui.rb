class TextUi
  attr_reader :player, :dealer, :deck, :players, :prize

  BET = 10
  BANK = 100

  def initialize
    @dealer = Player.new('Dealer', BANK)
    @prize = 0
    greetings
    @players = []
    @players << @dealer << @player
  end

  def greetings
    puts "Welcome to the Black Jack card game!\nPlease enter your name: "
    name = gets.chomp
    @player = Player.new(name, BANK)
    puts 'Thanks! Good luck!'
  end

  def new_deck
    @deck = Deck.new
  end

  def all_players
    @players.each { |player| yield(player) }
  end

  def bet
    all_players { |player| player.account -= BET }
    @prize = BET * 2
  end

  def init_deal
    2.times do
      all_players { |player| player.hand << deck.pick }
    end
  end

  def deal(player)
    player.hand << deck.pick
  end

  def choice
    print 'Enter 1 to skip a turn, 2 to pick a card, 3 to place cards on the table: '
    gets.chomp.to_i
  end

  def reset
    all_players { |player| player.hand = [] }
  end

  def cards_info
    print 'Your cards are:'
    @player.hand.each(&:to_s)
    puts "\nTotal score: #{@player.score}"
  end
end
