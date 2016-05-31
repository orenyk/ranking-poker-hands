require "spec_helper"
require "card_group/flush"

describe CardGroup::Flush do
  it_behaves_like "card group"

  describe "#valid?" do
    it "returns true if there are five cards with identical suits" do
      cards = [mock_card(2, "H"), mock_card(3, "H"), mock_card(8, "H"),
               mock_card(5, "H"), mock_card(10, "H")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_truthy
    end

    it "returns false if there are five cards without identical suits" do
      cards = [mock_card(2, "H"), mock_card(3, "S"), mock_card(8, "H"),
               mock_card(5, "H"), mock_card(10, "H")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_falsey
    end

    it "returns true if there aren't five cards" do
      cards = [mock_card(2, "H"), mock_card(3, "H"), mock_card(8, "H"),
               mock_card(5, "H")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_falsey
    end
  end

  describe "#score" do
    it "returns the high value times 15**5 if valid" do
      value = 7
      valid = described_class.new(cards: []).tap do |v|
        allow(v).to receive(:valid?).and_return(true)
        allow(v).to receive(:high_value).and_return(value)
      end
      expected_score = value * 15**5

      result = valid.score

      expect(result).to eq(expected_score)
    end

    it "returns 0 if invalid" do
      invalid = described_class.new(cards: []).tap do |i|
        allow(i).to receive(:valid?).and_return(false)
      end

      result = invalid.score

      expect(result).to eq(0)
    end
  end
end
