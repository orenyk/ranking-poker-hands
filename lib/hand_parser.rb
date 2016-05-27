class HandParser
  CARD_VALS = ("2".."9").to_a + %w(T J Q K A)
  SUITS = %w(C D H S)
  Card = Struct.new(:value, :suit)

  def self.parse(hand:)
    new(hand: hand).parse
  end

  def initialize(hand:)
    @hand = hand
  end

  def parse
    hand.map do |str|
      val_str, suit_str = str.split("")
      Card.new(value: value(val_str), suit: suit(suit_str))
    end
  end

  private

  attr_reader :hand

  def value(val_str)
    CARD_VALS.index(val_str) + 2
  end

  def suit(suit_str)
    SUITS.index(suit_str) + 1
  end

end
