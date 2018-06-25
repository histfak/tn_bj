class Board
  def initialize(players, interface)
    @players = players
    @deck = Deck.new
    @bank = 0
    @win = false
    @interface = interface
    reset
  end

  def game
    bet
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

  def turn
    @players.each do |player|
      if player.is_a?(Dealer)
        command = player.score >= 18 ? 3 : 1
      else
        @interface.choices
        command = @interface.ask_command.to_i
      end
      case command
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
    player = @players.first
    dealer = @players.last
    if (player.score > dealer.score && player.score <= 21) || (dealer.score > 21 && player.score <= 21)
      player.account += @bank
      @interface.player_wins(player)
    elsif dealer.score == player.score || (dealer.score > 21 && player.score > 21)
      @interface.draw
      player.account += @bank / 2
      dealer.account += @bank / 2
    elsif dealer.score <= 21 || player.score > 21
      dealer.account += @bank
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

  def bet
    @players.each { |player| player.account -= 10 }
    @bank += 20
  end

  def deal_cards
    2.times do
      @players.each { |player| player.hand << @deck.pick }
    end
  end

  def view_board
    @interface.player_cards_msg(@players.first)
    @players.first.hand.each { |card| @interface.card_to_s(card) }
    @interface.total_score(@players.first)
    @interface.new_line
  end
end
