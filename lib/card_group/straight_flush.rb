require "card_group/base"
require "card_group/straightlike"
require "card_group/flushlike"

class CardGroup::StraightFlush < CardGroup::Base
  include CardGroup::Straightlike
  include CardGroup::Flushlike

  def valid?
    valid_straight? && valid_flush?
  end
end
