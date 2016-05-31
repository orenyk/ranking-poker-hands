require "card_group/base"

class CardGroup::HighCard < CardGroup::Base
  def score
    high_value
  end
end
