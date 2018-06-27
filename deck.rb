require_relative 'card'

class Deck
  attr_accessor :deck

  def initialize
    @deck = Deck.new_deck
  end

  def self.new_deck
    @deck = []
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        @deck << Card.new(rank, suit)
      end
    end
    @deck.shuffle!
  end

  def pick
    @deck.shift
  end
end
