class Casino
  def initialize(interface)
    @interface = interface
  end

  def start
    name = @interface.ask_name
    @players = []
    @player = Player.new(name)
    @dealer = Dealer.new
    @players << @player << @dealer
    loop do
      @interface.player_account(@player.name, @player.account)
      board = Board.new(@players, @interface)
      board.game
      if @player.account <= 0
        @interface.player_lost_money
        break
      end
      if @dealer.account <= 0
        @interface.dealer_lost_money
        break
      end
      @interface.exit_msg
      command = gets.chomp
      break if %w[q Q].include?(command)
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end
end