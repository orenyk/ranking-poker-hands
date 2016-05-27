class CardGroup
  def initialize(cards:)
    @cards = cards
  end

  def high_card
    cards_sorted_by_value.first
  end

  private

  attr_reader :cards

  def cards_sorted_by_value
    cards.sort_by { |card| card[:value] }.reverse
  end
end
