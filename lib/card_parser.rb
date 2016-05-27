class CardParser
  CARD_VALS = ("2".."9").to_a + %w(T J Q K A)

  def self.parse(card_str:)
    new(card_str: card_str).parse
  end

  def initialize(card_str:)
    @card_str = card_str
  end

  def parse
    val_str, suit = card_str.split("")
    { value: value(val_str), suit: suit }
  end

  private

  attr_reader :card_str

  def value(val_str)
    CARD_VALS.index(val_str) + 2
  end
end
