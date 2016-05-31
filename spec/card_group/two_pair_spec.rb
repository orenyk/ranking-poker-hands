require "spec_helper"
require "card_group/two_pair"

describe CardGroup::TwoPair do
  it_behaves_like "card group"

  describe "#valid?" do
    it "returns true if the four cards contain two pairs" do
      cards = [mock_card(2, "C"), mock_card(2, "H"), mock_card(3, "S"),
               mock_card(3, "D")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_truthy
    end

    it "returns false if there are not two pairs" do
      cards = [mock_card(2, "C"), mock_card(3, "H"), mock_card(3, "S"),
               mock_card(3, "D")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_falsey
    end

    it "returns false if there are not four cards" do
      cards = [mock_card(2, "C"), mock_card(2, "H"), mock_card(3, "S"),
               mock_card(3, "D"), mock_card(4, "D")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_falsey
    end

    it "returns false if there are not four cards" do
      cards = [mock_card(2, "C"), mock_card(3, "H"), mock_card(2, "S"),
               mock_card(3, "D")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_truthy
    end
  end
end
