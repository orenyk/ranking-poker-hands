require "spec_helper"
require "card_group/n_of_a_kind"

describe CardGroup::NOfAKind do
  it_behaves_like "card group", { n: nil }

  describe "#valid?" do
    it "returns true if there are n cards with identical values" do
      cards = [mock_card(2, "C"), mock_card(2, "H"), mock_card(2, "D")]
      n = 3

      result = CardGroup::NOfAKind.new(cards: cards, n: n).valid?

      expect(result).to be_truthy
    end

    it "returns false if not all n cards have the same value" do
      cards = [mock_card(2, "C"), mock_card(2, "H"), mock_card(3, "D")]
      n = 3

      result = CardGroup::NOfAKind.new(cards: cards, n: n).valid?

      expect(result).to be_falsey
    end

    it "returns false if there are a different number of identical cards" do
      cards = [mock_card(2, "C"), mock_card(2, "H")]
      n = 3

      result = CardGroup::NOfAKind.new(cards: cards, n: n).valid?

      expect(result).to be_falsey
    end
  end
end
