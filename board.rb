require_relative 'deck'

class Board
  def initialize(players)
    @players = players
    @deck = Deck.new
    @bank = 0
    @win = false
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
        puts 'Enter 1 to pick a card' if player.hand.count < 3
        puts 'Enter 2 to place cards on the table'
        puts 'Enter 3 to skip the turn'
        command = gets.chomp.to_i
      end
      case command
      when 1 then player.hand << @deck.pick
      when 2
        check!
        break
      when 3 then puts 'skipping turn...'
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
      puts "#{player.name} wins"
    elsif (dealer.score <= 21 || player.score > 21) || dealer.score != player.score
      dealer.account += @bank
      puts 'Dealer wins'
    else
      puts 'Draw!'
    end
    @win = true
  end

  def view_all
    all_players do |player|
      print "Player #{player.name} has: "
      player.hand.each(&:to_s)
      puts "\nTotal score is #{player.score}"
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
    print "#{@players.first.name}\'s cards are:"
    @players.first.hand.each(&:to_s)
    puts "\nTotal score: #{@players.first.score}"
    print 'Dealer cards: '
    @players.last.hand.count.times { print '* ' }
    puts "\n"
  end
end
