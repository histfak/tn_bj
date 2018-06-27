class Board
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
    @players.each { |player| player.hand = [] }
  end

  def choice(player)
    if player.is_a?(Dealer)
      command = player.skip_choice
    else
      @interface.choices
      command = @interface.ask_command.to_i
    end
    command
  end

  def turn
    @players.each do |player|
      case choice(player)
      when 1 then player.hand << @deck.pick
      when 2
        check
        break
      when 3 then @interface.skipping_turn
      else break
      end
    end
    check if @players.any? { |player| player.hand.count == 3 }
  end

  def check
    view_all
    if @player.score > @dealer.score && @player.score <= 21 || @dealer.score > 21 && @player.score <= 21
      @accounting.plus(@player)
      @interface.player_wins(@player)
    elsif @dealer.score == @player.score || (@dealer.score > 21 && @player.score > 21)
      @interface.draw
      @accounting.draw(@players)
    elsif @dealer.score <= 21 || @player.score > 21
      @accounting.plus(@dealer)
      @interface.dealer_wins
    end
    @win = true
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
