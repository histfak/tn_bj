class Dealer < Player
  LIMIT = 18

  def initialize
    super('Dealer')
  end

  def skip_or_not
    score >= LIMIT ? 3 : 1
  end
end
