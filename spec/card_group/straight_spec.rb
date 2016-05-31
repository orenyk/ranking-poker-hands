require "spec_helper"
require "card_group/straight"

describe CardGroup::Straight do
  it_behaves_like "card group"

  describe "#valid?" do
    it "returns true if there are five cards with sequential values" do
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

    it "returns false if there are not five cards" do
      cards = [mock_card(2, "H"), mock_card(3, "C"), mock_card(4, "D"),
               mock_card(5, "S")]

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

  describe "#score" do
    it "returns the high value times 15**4 if valid" do
      value = 7
      valid = described_class.new(cards: []).tap do |v|
        allow(v).to receive(:valid?).and_return(true)
        allow(v).to receive(:high_value).and_return(value)
      end
      expected_score = value * 15**4

      result = valid.score

      expect(result).to eq(expected_score)
    end

    it "returns 5 times 15**4 for an aces low straight" do
      valid = described_class.new(cards: []).tap do |v|
        allow(v).to receive(:valid?).and_return(true)
        allow(v).to receive(:aces_low_straight?).and_return(true)
      end
      expected_score = 5 * 15**4

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
