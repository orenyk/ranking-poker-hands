require "card_group/base"
require "card_group/flushlike"

class CardGroup::Flush < CardGroup::Base
  include CardGroup::Flushlike

  def valid?
    valid_flush?
  end
end
