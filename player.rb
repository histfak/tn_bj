class Player
  attr_reader :name
  attr_accessor :hand, :account

  def initialize(name, bank)
    @name = name
    @account = bank
    @hand = []
  end

  def score
    score = 0
    @hand.each do |card|
      case card.rank
      when 'A' then score += 1
      when '2', '3', '4', '5', '6', '7', '8', '9' then score += card.rank.to_i
      when '10', 'J', 'Q', 'K' then score += 10
      end
    end
    score += 10 if @hand.any? { |card| card.rank == 'A' } && score <= 11
    score
  end
end
