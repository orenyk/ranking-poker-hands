require "card_group/base"
require "card_group/n_of_a_kind"

class CardGroup::TwoPair < CardGroup::Base
  def valid?
    size == 4 && contains_two_pairs?
  end

  def score
    return 0 unless valid?
    high_value * 15**2 + low_value * 15
  end

  private

  def contains_two_pairs?
    return false if num_unique_values != 2

    unique_values.each do |val|
      cards = cards_with_value(val)
      return false unless valid_pair?(cards)
    end

    true
  end

  def valid_pair?(cards)
    CardGroup::NOfAKind.new(cards: cards, n: 2).valid?
  end

  def low_value
    unique_values.min
  end
end
