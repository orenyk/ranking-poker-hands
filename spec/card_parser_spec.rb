require "spec_helper"
require "card_parser"

describe CardParser do

  describe "#parse" do
    it "converts a card string into a hash with a value and suit" do
      cards = %w(2S 3C 4C 4S 6H)
      expected = [mock_card(2, "S"), mock_card(3, "C"), mock_card(4, "C"),
                  mock_card(4, "S"), mock_card(6, "H")]

      cards.each_with_index do |card, ind|
        result = CardParser.new(card: card).parse

        expect(result).to eq(expected[ind])
      end
    end

    it "properly converts aces, tens, jacks, queens, and kings" do
      cards = %w(AC TH JS QC KD)
      expected = [mock_card(14, "C"), mock_card(10, "H"), mock_card(11, "S"),
                  mock_card(12, "C"), mock_card(13, "D")]

      cards.each_with_index do |card, ind|
        result = CardParser.new(card: card).parse

        expect(result).to eq(expected[ind])
      end
    end
  end

  describe ".parse" do
    it "passes the card to a new instance of CardParser and calls parse" do
      cards = %w(2S 3C 4C 4S 6H)
      expected = [mock_card(2, "S"), mock_card(3, "C"), mock_card(4, "C"),
                  mock_card(4, "S"), mock_card(6, "H")]

      cards.each_with_index do |card, ind|
        result = CardParser.new(card: card).parse

        expect(result).to eq(expected[ind])
      end
    end
  end

  def mock_card(value, suit)
    { value: value, suit: suit }
  end
end
