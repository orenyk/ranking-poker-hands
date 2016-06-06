require "card_group/base"

class CardGroup::HighCard < CardGroup::Base
  def score
    card_value_decimal
  end
end
