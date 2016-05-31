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

  describe "#score" do
    it "returns the high value times 15**6 if valid" do
      value = 7
      valid = described_class.new(cards: []).tap do |v|
        allow(v).to receive(:valid?).and_return(true)
        allow(v).to receive(:high_value).and_return(value)
      end
      expected_score = value * 15**6

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
