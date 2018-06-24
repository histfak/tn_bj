#!/usr/bin/env ruby
require_relative 'card'
require_relative 'deck'
require_relative 'board'
require_relative 'player'
require_relative 'dealer'

class Main
  def start
    print 'Please enter your name: '
    name = gets.chomp
    @players = []
    @player = Player.new(name)
    @dealer = Dealer.new
    @players << @player << @dealer
    loop do
      puts "#{@player.name}\'s account: $#{@player.account}"
      board = Board.new(@players)
      board.game
      break if @player.account <= 0 || @dealer.account <= 0
      puts 'Press any key if you want to play again or press Q to exit'
      command = gets.chomp
      break if %w[q Q].include?(command)
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end
end

bj = Main.new
bj.start
