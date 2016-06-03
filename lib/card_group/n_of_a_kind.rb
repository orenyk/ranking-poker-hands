require "card_group/base"

class CardGroup::NOfAKind < CardGroup::Base
  SCORE_BASE = { 2 => 15, 3 => 15**3, 4 => 15**7 }

  attr_reader :n

  def initialize(cards:, n:)
    @n = n
    super
    filter_cards
  end

  def valid?
    num_unique_values == 1 && size == n
  end

  def score
    return 0 unless valid?

    begin
      SCORE_BASE[n] * high_value
    rescue
      0
    end
  end

  private

  def filter_cards
    return if set_vals.empty?
    raise ArgumentError, "Multiple sets present." if set_vals.length > 1
    cards.keep_if { |c| c.value == set_vals.first }
  end

  def num_cards_of_each_value
    Hash[unique_values.collect { |v| [v, cards_with_value(v).length] }]
  end

  def set_vals
    num_cards_of_each_value.select { |_k, v| v == n }.keys
  end
end
