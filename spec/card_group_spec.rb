require "spec_helper"
require "card_group"

describe CardGroup do
  describe "#high_card" do
    it "returns the highest card in the group of cards" do
      cards = [mock_card(2, "C"), mock_card(13, "H"), mock_card(10, "D")]

      result = CardGroup.new(cards: cards).high_card

      expect(result).to eq(mock_card(13, "H"))
    end
  end

  describe "#high_value" do
    it "returns the value of the highest card" do
      cards = [mock_card(2, "C"), mock_card(13, "H"), mock_card(10, "D")]

      result = CardGroup.new(cards: cards).high_value

      expect(result).to eq(13)
    end
  end
end
