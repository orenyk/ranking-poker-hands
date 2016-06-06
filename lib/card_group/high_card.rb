require "card_group/base"

class CardGroup::HighCard < CardGroup::Base
  def score
    cards_sorted_by_value.map.with_index(1) do |c, i|
      c.value / (100.0 ** i)
    end.inject(&:+)
  end
end
