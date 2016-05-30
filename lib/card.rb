class Card
  CARD_VALS = ("2".."9").to_a + %w(T J Q K A)
  SUIT_VALS = %W(C D H S)

  attr_reader :value, :suit

  def self.parse(card_str:)
    new(card_str: card_str)
  end

  def initialize(card_str:)
    parse_card_str(card_str)
  end

  private

  def parse_card_str(card_str)
    val_str, suit_str = card_str.split("")
    @value = convert_value(val_str)
    @suit = convert_suit(suit_str)
  end

  def convert_value(val_str)
    begin
      CARD_VALS.index(val_str) + 2
    rescue
      raise ArgumentError, "Invalid card value"
    end
  end

  def convert_suit(suit_str)
    return suit_str if SUIT_VALS.include? suit_str
    raise ArgumentError, "Invalid suit value"
  end
end
