class CardParser
  CARD_VALS = ("2".."9").to_a + %w(T J Q K A)

  def self.parse(card:)
    new(card: card).parse
  end

  def initialize(card:)
    @card = card
  end

  def parse
    val_str, suit = card.split("")
    { value: value(val_str), suit: suit }
  end

  private

  attr_reader :card

  def value(val_str)
    CARD_VALS.index(val_str) + 2
  end
end
