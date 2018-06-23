class Deck
  attr_accessor :cards

  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = %w[♠ ♣ ♦ ♥].freeze

  def initialize
    @cards = Deck.new_deck
  end

  def self.new_deck
    @cards = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        @cards << Card.new(rank, suit)
      end
    end
    @cards.shuffle!
  end

  def remained
    @cards.size
  end

  def pick
    @cards.shift
  end
end
