require "spec_helper"
require "card_group/high_card"

describe CardGroup::HighCard do
  it_behaves_like "card group", {}

  describe "#score" do
    it "returns the value of the high card" do
      high_value = 13
      cards = [mock_card(2, "C"), mock_card(high_value, "H")]

      result = described_class.new(cards: cards).score

      expect(result).to eq(high_value)
    end
  end
end
