class Dealer < Player
  def initialize
    super('Dealer')
  end

  def skip_choice
    score >= 18 ? 3 : 1
  end
end
