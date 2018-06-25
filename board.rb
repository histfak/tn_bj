require_relative 'deck'
require_relative 'interface'

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

  def all_players
    @players.each { |player| yield(player) }
  end

  def reset
    all_players { |player| player.hand = [] }
  end

  def turn
    all_players do |player|
      if player.is_a?(Dealer)
        command = player.score >= 18 ? 3 : 1
      else
        puts Interface::CHOICES[:c1] if player.hand.count < 3
        puts Interface::CHOICES[:c2]
        puts Interface::CHOICES[:c3]
        command = gets.chomp.to_i
      end
      case command
      when 1 then player.hand << @deck.pick
      when 2
        check!
        break
      when 3 then @interface.skipping_turn
      end
    end
    check! if @players.any? { |player| player.hand.count == 3 }
  end

  def check!
    view_all
    player = @players.first
    dealer = @players.last
    if (player.score > dealer.score && player.score <= 21) || (dealer.score > 21 && player.score <= 21)
      player.account += @bank
      @interface.player_wins(player)
    elsif dealer.score <= 21 && player.score > 21
      dealer.account += @bank
      @interface.dealer_wins
    elsif dealer.score == player.score
      @interface.draw
      player.account += @bank/2
      dealer.account += @bank/2
    end
    @win = true
  end

  def view_all
    all_players do |player|
      @interface.player_has(player)
      player.hand.each { |card| @interface.card_to_s(card) }
      @interface.total_score(player)
    end
  end

  def bet
    all_players { |player| player.account -= 10 }
    @bank += 20
  end

  def deal_cards
    2.times do
      all_players { |player| player.hand << @deck.pick }
    end
  end

  def view_board
    @interface.player_cards_msg(@players.first)
    @players.first.hand.each { |card| @interface.card_to_s(card) }
    @interface.total_score(@players.first)
    @interface.new_line
  end
end
