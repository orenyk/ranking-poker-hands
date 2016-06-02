require "spec_helper"
require "card_group/parser"

describe CardGroup::Parser do
  describe "#parse" do

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
