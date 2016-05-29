require "spec_helper"
require "n_of_a_kind"

describe NOfAKind do
  it_behaves_like "CardGroup"

  describe "#valid?" do
    it "returns true if all card values are the same" do
      cards = [mock_card(2, "C"), mock_card(2, "H"), mock_card(2, "D")]

      result = NOfAKind.new(cards: cards).valid?

      expect(result).to be_truthy
    end

    it "returns false if all of the card values are not the same" do
      cards = [mock_card(2, "C"), mock_card(2, "H"), mock_card(3, "D")]

      result = NOfAKind.new(cards: cards).valid?

      expect(result).to be_falsey
    end
  end
end
