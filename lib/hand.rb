require "card"
require "card_group/parser"

class Hand
  attr_accessor :card_groups, :card_strs

  def initialize(card_strs:)
    @card_strs = card_strs
    @card_groups = CardGroup::Parser.parse(cards: extract_cards)
  end

  def score
    card_groups.reduce(0) { |a, e| a + e.score }
  end

  private

  def extract_cards
    card_strs.map { |card_str| Card.new(card_str: card_str) }
  end
end
