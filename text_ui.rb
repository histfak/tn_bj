class TextUi
  attr_reader :player, :dealer, :deck

  BET = 10
  BANK = 100

  def initialize
    @dealer = Player.new('Dealer', BANK)
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

  def init_deal
    2.times { @player.hand << deck.pick }
    2.times { @dealer.hand << deck.pick }
  end

  def deal(player)
    player.hand << deck.pick
  end
end
