require "spec_helper"
require "hand_parser"

describe HandParser do
  before(:all) { HandParser::Card = Struct.new(:value, :suit) }

  describe "#parse" do
    it "converts each card to a struct with a value and a suit" do
      hand = %w(2S 3C 4C 4S 6H)
      expected = [mock_card(2, 4), mock_card(3, 1), mock_card(4, 1),
                  mock_card(4, 4), mock_card(6, 3)]

      result = HandParser.new(hand: hand).parse

      expect(result).to eq(expected)
    end

    it "properly converts aces, tens, jacks, queens, and kings" do
      hand = %w(AC TH JS QC KD)
      expected = [mock_card(14, 1), mock_card(10, 3), mock_card(11, 4),
                  mock_card(12, 1), mock_card(13, 2)]

      result = HandParser.new(hand: hand).parse

      expect(result).to eq(expected)
    end
  end

  describe ".parse" do
    it "passes the hand to a new instance of HandParser and calls parse" do
      hand = %w(2S 3C 4C 4S 6H)
      expected = [mock_card(2, 4), mock_card(3, 1), mock_card(4, 1),
                  mock_card(4, 4), mock_card(6, 3)]

      result = HandParser.parse(hand: hand)

      expect(result).to eq(expected)
    end
  end

  def mock_card(value, suit)
    HandParser::Card.new(value: value, suite: suit)
  end
end
