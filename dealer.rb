class Dealer < Player
  LIMIT = 18

  def initialize
    super('Dealer')
  end

  def skip_or_not
    score >= LIMIT ? :skip : :pick
  end
end
