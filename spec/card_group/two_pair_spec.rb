require "spec_helper"
require "card_group/two_pair"

describe CardGroup::TwoPair do
  it_behaves_like "card group"

  describe ".new" do
    it "removes any extra cards other than the two pairs if valid" do
      pairs = [mock_card(2, "C"), mock_card(2, "H"), mock_card(3, "C"),
             mock_card(3, "H")]
      cards = pairs << mock_card(4, "C")

      result = described_class.new(cards: cards).cards

      expect(result).to eq(pairs)
    end

    it "leaves the cards array intact for an invalid set" do
      cards = [mock_card(2, "C"), mock_card(3, "C")]

      result = described_class.new(cards: cards).cards

      expect(result).to eq(cards)
    end
  end

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
               mock_card(5, "D"), mock_card(4, "D")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_falsey
    end

    it "doesn't care about the card order" do
      cards = [mock_card(2, "C"), mock_card(3, "H"), mock_card(2, "S"),
               mock_card(3, "D")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_truthy
    end
  end

  describe "#score" do
    it "returns high value times 15**2 plus low value times 15 if valid" do
      high_val = 4
      low_val = 3
      valid = described_class.new(cards: []).tap do |v|
        allow(v).to receive(:valid?).and_return(true)
        allow(v).to receive(:high_value).and_return(high_val)
        allow(v).to receive(:low_value).and_return(low_val)
      end
      expected_score = high_val * 15**2 + low_val * 15

      result = valid.score

      expect(result).to eq(expected_score)
    end

    it "returns zero when invalid" do
      invalid = described_class.new(cards: []).tap do |i|
        allow(i).to receive(:valid?).and_return(false)
      end

      result = invalid.score

      expect(result).to eq(0)
    end
  end
end
