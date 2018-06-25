class Interface
  def ask_name
    print 'Please enter your name: '
    name = gets.chomp
    name
  end

  def ask_command
    command = gets.chomp
    command
  end

  def choices
    puts "Enter 1 to pick a card\nEnter 2 to place cards on the table\nEnter 3 to skip the turn"
  end

  def player_lost_money
    puts 'You lost all the money! Be careful, gambling is an addiction!'
  end

  def dealer_lost_money
    puts 'You won!'
  end

  def exit_msg
    puts 'Press any key if you want to play again or press Q to exit'
  end

  def player_account(name, account)
    puts "#{name}\'s account: $#{account}"
  end

  def card_to_s(card)
    print " #{card.rank}#{card.suit} "
  end

  def skipping_turn
    puts 'skipping turn...'
  end

  def dealer_wins
    puts 'Dealer wins'
  end

  def player_wins(player)
    puts "#{player.name} wins"
  end

  def draw
    puts 'Draw!'
  end

  def total_score(player)
    puts "\nTotal score is #{player.score}"
  end

  def player_has(player)
    print "Player #{player.name} has: "
  end

  def dealer_cards_msg
    print 'Dealer cards: '
  end

  def player_cards_msg(player)
    print "#{player.name}\'s cards are:"
  end

  def new_line
    puts "\n"
  end
end
