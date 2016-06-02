require "card_group"

class CardGroup::Parser < CardGroup::Base
  attr_accessor :cards

  def self.parse(cards:)
    new(cards: cards).parse
  end

  def initialize(cards:)
    @cards = cards
  end
end
