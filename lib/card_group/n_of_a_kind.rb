require "card_group/base"

class CardGroup::NOfAKind < CardGroup::Base
  def initialize(cards:, n:)
    @n = n
    super(cards: cards)
  end

  def valid?
    num_unique_values == 1 && size == n
  end

  private

  attr_reader :n
end
