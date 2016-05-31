require "card_group/base"

class CardGroup::Straight < CardGroup::Base
  def valid?
    ordered_values == expected_straight
  end

  private

  attr_accessor :cards

  def ordered_values
    return (1..5).to_a if aces_low_straight?
    card_values.sort
  end

  def card_values
    cards.map { |card| card.value }
  end

  def expected_straight
    return (1..5).to_a if aces_low_straight?
    ((high_value - 4)..high_value).to_a
  end

  def aces_low_straight?
    ([2, 3, 4, 5, 14] - card_values).empty?
  end
end