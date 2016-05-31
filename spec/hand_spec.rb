require "spec_helper"
require "hand"

describe Hand do
  describe ".new" do
    it "properly identifies straight flushes" do
      card_strs = %w(2C 3C 4C 5C 6C)
      hand = Hand.new(card_strs: card_strs)

      result = hand.is_straight_flush?

      expect(result).to be_truthy
    end
  end
end
