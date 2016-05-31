require "card_group/base"
require "card_group/straightlike"
require "card_group/flushlike"

class CardGroup::StraightFlush < CardGroup::Base
  include CardGroup::Straightlike
  include CardGroup::Flushlike

  def valid?
    valid_straight? && valid_flush?
  end

  def score
    return 0 unless valid?
    high_value * 15**8
  end
end
