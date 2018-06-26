class Casino
  def initialize(interface)
    @interface = interface
    @players = []
    @dealer = Dealer.new
  end

  def start
    greetings
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

  def greetings
    name = @interface.ask_name
    @player = Player.new(name)
    @players << @player << @dealer
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def quit
    @interface.exit_msg
    command = @interface.ask_command
    %w[q Q].include?(command)
  end
end
