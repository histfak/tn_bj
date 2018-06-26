class Accounting
  def initialize
    @bank = 0
  end

  def bet(players)
    players.each { |player| player.account -= 10 }
    @bank += 20
  end

  def plus(player)
    player.account += @bank
  end

  def draw(players)
    players.each { |player| player.account += @bank / 2 }
  end
end
