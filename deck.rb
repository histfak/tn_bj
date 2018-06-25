require_relative 'card'

class Deck
  attr_accessor :deck

  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = %w[♠ ♣ ♦ ♥].freeze

  def initialize
    @deck = Deck.new_deck
  end

  def self.new_deck
    @deck = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        @deck << Card.new(rank, suit)
      end
    end
    @deck.shuffle!
  end

  def pick
    @deck.shift
  end
end
