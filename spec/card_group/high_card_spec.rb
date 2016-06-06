require "spec_helper"
require "card_group/high_card"

describe CardGroup::HighCard do
  it_behaves_like "card group"

  describe "#score" do
    it "returns the card values strung together as a decimal in order" do
      cards = [mock_card(2, "C"), mock_card(13, "H")]
      expected = 0.1302

      result = described_class.new(cards: cards).score

      expect(result).to eq(expected)
    end
  end
end
