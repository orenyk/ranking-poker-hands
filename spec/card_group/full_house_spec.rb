require "spec_helper"
require "card_group/full_house"

describe CardGroup::FullHouse do
  describe "#valid?" do
    it "returns true if there is a three of a kind and a pair together" do
      cards = [mock_card(3, "C"), mock_card(3, "D"), mock_card(3, "S"),
               mock_card(2, "H"), mock_card(2, "D")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_truthy
    end

    it "returns false if there is only a three of a kind and a single card" do
      cards = [mock_card(3, "C"), mock_card(3, "D"), mock_card(3, "S"),
               mock_card(2, "H")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_falsey
    end

    it "doesn't care about the order" do
      cards = [mock_card(3, "C"), mock_card(2, "D"), mock_card(3, "S"),
               mock_card(2, "H"), mock_card(3, "D")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_truthy
    end
  end
end
