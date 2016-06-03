require "spec_helper"
require "card_group/n_of_a_kind"

describe CardGroup::NOfAKind do
  it_behaves_like "card group", n: nil

  describe ".new" do
    it "removes any non-set cards for a valid set" do
      set = [mock_card(2, "C"), mock_card(2, "H")]
      cards = set << mock_card(3, "C")
      n = 2

      result = described_class.new(cards: cards, n: n).cards

      expect(result).to eq(set)
    end

    it "leaves the cards array intact for an invalid set" do
      cards = [mock_card(2, "C"), mock_card(3, "C")]
      n = 2

      result = described_class.new(cards: cards, n: n).cards

      expect(result).to eq(cards)
    end
  end

  describe "#valid?" do
    it "returns true if there are n cards with identical values" do
      cards = [mock_card(2, "C"), mock_card(2, "H"), mock_card(2, "D")]
      n = 3

      result = described_class.new(cards: cards, n: n).valid?

      expect(result).to be_truthy
    end

    it "returns false if not all n cards have the same value" do
      cards = [mock_card(2, "C"), mock_card(2, "H"), mock_card(3, "D")]
      n = 3

      result = described_class.new(cards: cards, n: n).valid?

      expect(result).to be_falsey
    end

    it "returns false if there are a different number of identical cards" do
      cards = [mock_card(2, "C"), mock_card(2, "H")]
      n = 3

      result = described_class.new(cards: cards, n: n).valid?

      expect(result).to be_falsey
    end
  end

  describe "#score" do
    it "returns the high value times 15 for a pair" do
      value = 3
      pair = mock_valid_set(value: value, n: 2)
      expected_score = value * 15

      result = pair.score

      expect(result).to eq(expected_score)
    end

    it "returns the high value times 15**3 for a three-of-a-kind" do
      value = 3
      three_of_a_kind = mock_valid_set(value: value, n: 3)
      expected_score = value * 15**3

      result = three_of_a_kind.score

      expect(result).to eq(expected_score)
    end

    it "returns the high value times 15**7 for a four-of-a-kind" do
      value = 3
      four_of_a_kind = mock_valid_set(value: value, n: 4)
      expected_score = value * 15**7

      result = four_of_a_kind.score

      expect(result).to eq(expected_score)
    end

    it "returns 0 if invalid" do
      invalid = described_class.new(cards: [], n: 2).tap do |i|
        allow(i).to receive(:valid?).and_return(false)
      end

      result = invalid.score

      expect(result).to eq(0)
    end

    it "returns 0 if only a single card" do
      single = mock_valid_set(value: 3, n: 1)

      result = single.score

      expect(result).to eq(0)
    end

    def mock_valid_set(value:, n:)
      described_class.new(cards: [], n: n).tap do |set|
        allow(set).to receive(:valid?).and_return(true)
        allow(set).to receive(:high_value).and_return(value)
      end
    end
  end
end
