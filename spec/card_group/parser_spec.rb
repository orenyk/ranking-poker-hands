require "spec_helper"
require "card_group/parser"

describe CardGroup::Parser do
  describe "#parse" do
    shared_examples_for "returns a single card group" do |klass|
      it "successfully" do
        expect(@result.length).to eq(1)
        expect(@result.first).to be_a klass
        expect(@result.first.valid?).to be_truthy
      end
    end

    shared_examples_for "returns two card groups" do |klass, n|
      it "successfully" do
        expect(@result.length).to eq(2)
        expect(@result.first).to be_a klass
        expect(@result[1]).to be_a CardGroup::HighCard
        expect(@result.first.n).to eq(n) if n
        expect(@result.first.valid?).to be_truthy
      end
    end

    context "for a straight flush" do
      before(:each) do
        cards = [mock_card(2, "C"), mock_card(3, "C"), mock_card(4, "C"),
                 mock_card(5, "C"), mock_card(6, "C")]

        @result = described_class.parse(cards: cards)
      end

      it_behaves_like "returns a single card group", CardGroup::StraightFlush
    end

    context "for a four of a kind" do
      before(:each) do
        cards = [mock_card(2, "C"), mock_card(2, "H"), mock_card(2, "D"),
                 mock_card(2, "S"), mock_card(6, "C")]

        @result = described_class.parse(cards: cards)
      end

      it_behaves_like "returns two card groups", CardGroup::NOfAKind, 4
    end

    context "for a full house" do
      before(:each) do
        cards = [mock_card(2, "C"), mock_card(2, "S"), mock_card(2, "H"),
                 mock_card(5, "C"), mock_card(5, "S")]

        @result = described_class.parse(cards: cards)
      end

      it_behaves_like "returns a single card group", CardGroup::FullHouse
    end

    context "for a flush" do
      before(:each) do
        cards = [mock_card(8, "C"), mock_card(3, "C"), mock_card(4, "C"),
                 mock_card(5, "C"), mock_card(6, "C")]

        @result = described_class.parse(cards: cards)
      end

      it_behaves_like "returns a single card group", CardGroup::Flush
    end

    context "for a straight" do
      before(:each) do
        cards = [mock_card(2, "S"), mock_card(3, "C"), mock_card(4, "C"),
                 mock_card(5, "C"), mock_card(6, "C")]

        @result = described_class.parse(cards: cards)
      end

      it_behaves_like "returns a single card group", CardGroup::Straight
    end

    context "for a three of a kind" do
      before(:each) do
        cards = [mock_card(2, "C"), mock_card(2, "S"), mock_card(2, "H"),
                 mock_card(5, "C"), mock_card(6, "C")]

        @result = described_class.parse(cards: cards)
      end

      it_behaves_like "returns two card groups", CardGroup::NOfAKind, 3
    end

    context "for a two pair" do
      before(:each) do
        cards = [mock_card(2, "C"), mock_card(2, "H"), mock_card(4, "C"),
                 mock_card(4, "S"), mock_card(6, "C")]

        @result = described_class.parse(cards: cards)
      end

      it_behaves_like "returns two card groups", CardGroup::TwoPair
    end

    context "for a pair" do
      before(:each) do
        cards = [mock_card(2, "C"), mock_card(2, "H"), mock_card(4, "C"),
                 mock_card(5, "C"), mock_card(6, "C")]

        @result = described_class.parse(cards: cards)
      end

      it_behaves_like "returns two card groups", CardGroup::NOfAKind, 2
    end

    context "for a high card" do
      it "returns a single card group" do
        cards = [mock_card(2, "S"), mock_card(3, "C"), mock_card(4, "S"),
                 mock_card(5, "H"), mock_card(7, "D")]

        result = described_class.parse(cards: cards)

        expect(result.length).to eq(1)
        expect(result.first).to be_a CardGroup::HighCard
      end
    end
  end

  describe ".parse" do
    it "passes the cards to .new and calls #parse on the resulting instance" do
      cards = []
      hp = double("hand parser").tap do |obj|
        allow(obj).to receive(:parse)
        allow(described_class).to receive(:new)
        .with(cards: cards).and_return(obj)
      end

      described_class.parse(cards: cards)

      expect(hp).to have_received(:parse)
    end
  end
end
