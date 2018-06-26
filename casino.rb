class Casino
  def initialize(interface)
    @interface = interface
    name = @interface.ask_name
    @players = []
    @player = Player.new(name)
    @dealer = Dealer.new
    @players << @player << @dealer
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def start
    loop do
      @interface.player_account(@player.name, @player.account)
      board = Board.new(@players, @interface)
      board.game
      if @player.account <= 0
        @interface.player_lost_money
        break
      elsif @dealer.account <= 0
        @interface.dealer_lost_money
        break
      end
      break if quit
    end
  end

  private

  def quit
    @interface.exit_msg
    command = @interface.ask_command
    true if %w[q Q].include?(command)
  end
end
