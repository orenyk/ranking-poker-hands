require "spec_helper"
require "card_group/straight"

describe CardGroup::Straight do
  it_behaves_like "card group", {}

  describe "#valid?" do
    it "returns true if the card values are in sequential order" do
      cards = [mock_card(2, "H"), mock_card(3, "C"), mock_card(4, "D"),
               mock_card(5, "S"), mock_card(6, "H")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_truthy
    end

    it "returns false if the card values are not in sequential order" do
      cards = [mock_card(2, "H"), mock_card(3, "C"), mock_card(4, "D"),
               mock_card(7, "S"), mock_card(6, "H")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_falsey
    end

    it "doesn't care about the order of the cards" do
      cards = [mock_card(3, "H"), mock_card(2, "C"), mock_card(4, "D"),
               mock_card(5, "S"), mock_card(6, "H")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_truthy
    end

    it "accepts aces high straights" do
      cards = [mock_card(10, "H"), mock_card(11, "C"), mock_card(14, "D"),
               mock_card(12, "S"), mock_card(13, "H")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_truthy
    end

    it "accepts aces low straights" do
      cards = [mock_card(3, "H"), mock_card(2, "C"), mock_card(4, "D"),
               mock_card(5, "S"), mock_card(14, "H")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_truthy
    end
  end
end
