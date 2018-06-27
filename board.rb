class Board
  MAX_POINTS = 21
  MAX_CARDS = 3

  def initialize(player, dealer, interface)
    @player = player
    @dealer = dealer
    @players = []
    @players << player << dealer
    @deck = Deck.new
    @accounting = Accounting.new
    @win = false
    @interface = interface
    reset
  end

  def game
    @accounting.bet(@players)
    deal_cards
    loop do
      view_board
      turn
      break if @win
    end
  end

  private

  def reset
    @players.each(&:reset)
  end

  def choice(player)
    if player.is_a?(Dealer)
      command = player.skip_or_not
    else
      @interface.choices
      command = @interface.ask_command
    end
    command
  end

  def turn
    @players.each do |player|
      case choice(player)
      when :pick then player.hand << @deck.pick
      when :place
        check
        break
      when :skip then @interface.skipping_turn
      else break
      end
    end
    check if @players.any? { |player| player.hand.count == MAX_CARDS }
  end

  def check
    view_all
    if win?
      @accounting.plus(@player)
      @interface.player_wins(@player)
    elsif draw?
      @interface.draw
      @accounting.draw(@players)
    elsif lose?
      @accounting.plus(@dealer)
      @interface.dealer_wins
    end
    @win = true
  end

  def win?
    @player.score > @dealer.score && @player.score <= MAX_POINTS || @dealer.score > MAX_POINTS && @player.score <= MAX_POINTS
  end

  def draw?
    @dealer.score == @player.score || (@dealer.score > MAX_POINTS && @player.score > MAX_POINTS)
  end

  def lose?
    @dealer.score <= MAX_POINTS || @player.score > MAX_POINTS
  end

  def view_all
    @players.each do |player|
      @interface.player_has(player)
      player.hand.each { |card| @interface.card_to_s(card) }
      @interface.total_score(player)
    end
  end

  def deal_cards
    2.times do
      @players.each { |player| player.hand << @deck.pick }
    end
  end

  def view_board
    @interface.player_cards_msg(@player)
    @player.hand.each { |card| @interface.card_to_s(card) }
    @interface.total_score(@player)
    @interface.new_line
  end
end
