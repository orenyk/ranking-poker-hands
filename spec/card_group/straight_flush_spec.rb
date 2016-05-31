require "spec_helper"
require "card_group/straight_flush"

describe CardGroup::StraightFlush do
  it_behaves_like "card group"

  describe "#valid?" do
    it "returns true if there is a five card straight flush" do
      cards = [mock_card(2, "C"), mock_card(3, "C"), mock_card(4, "C"),
               mock_card(5, "C"), mock_card(6, "C")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_truthy
    end

    it "returns false if it isn't a straight" do
      cards = [mock_card(2, "C"), mock_card(3, "C"), mock_card(4, "C"),
               mock_card(7, "C"), mock_card(6, "C")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_falsey

    end

    it "returns false if it isn't a flush" do
      cards = [mock_card(2, "C"), mock_card(3, "C"), mock_card(4, "C"),
               mock_card(5, "D"), mock_card(6, "C")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_falsey

    end

    it "returns false if there aren't five cards" do
      cards = [mock_card(2, "C"), mock_card(3, "C"), mock_card(4, "C"),
               mock_card(5, "C")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_falsey

    end

    it "doesn't care about the order" do
      cards = [mock_card(3, "C"), mock_card(2, "C"), mock_card(4, "C"),
               mock_card(5, "C"), mock_card(6, "C")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_truthy
    end
  end

  describe "#score" do
    it "returns the high value times 15**8 if valid" do
      value = 7
      valid = described_class.new(cards: []).tap do |v|
        allow(v).to receive(:valid?).and_return(true)
        allow(v).to receive(:high_value).and_return(value)
      end
      expected_score = value * 15**8

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
