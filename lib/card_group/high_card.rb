require "card_group/base"

class CardGroup::HighCard < CardGroup::Base
  def valid?
    false
  end

  def score
    high_value
  end
end
