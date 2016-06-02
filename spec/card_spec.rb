require "spec_helper"
require "card"

describe Card do
  describe ".new" do
    it "converts a card string into a hash with a value and suit" do
      cards = %w(2S 3C 4C 4S 6H)
      expected_vals = [2, 3, 4, 4, 6]
      expected_suits = %w(S C C S H)

      cards.each_with_index do |card, ind|
        result = described_class.new(card_str: card)

        expect(result.value).to eq(expected_vals[ind])
        expect(result.suit).to eq(expected_suits[ind])
      end
    end

    it "properly converts aces, tens, jacks, queens, and kings" do
      cards = %w(AC TH JS QC KD)
      expected_vals = [14, 10, 11, 12, 13]
      expected_suits = %w(C H S C D)

      cards.each_with_index do |card, ind|
        result = described_class.new(card_str: card)

        expect(result.value).to eq(expected_vals[ind])
        expect(result.suit).to eq(expected_suits[ind])
      end
    end

    it "raises an error when an invalid value character is passed" do
      expect { described_class.new(card_str: "1C") }.to \
        raise_error(ArgumentError)
    end

    it "raises an error when an invalid suit character is passed" do
      expect { described_class.new(card_str: "2A") }.to \
        raise_error(ArgumentError)
    end
  end

  describe ".parse" do
    it "creates a new card from the passed card string" do
      card_str = double("card_str")
      allow(Card).to receive(:new).with(card_str: card_str)

      described_class.parse(card_str: card_str)

      expect(Card).to have_received(:new).with(card_str: card_str)
    end
  end
end
