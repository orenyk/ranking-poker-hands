require "card_group/base"

class CardGroup::NOfAKind < CardGroup::Base
  SCORE_BASE = { 2 => 15, 3 => 15**3, 4 => 15**7 }

  attr_reader :n

  def initialize(cards:, n:)
    @n = n
    super(cards: cards)
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
end
