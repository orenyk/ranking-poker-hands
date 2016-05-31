require "card_group/base"
require "card_group/straightlike"

class CardGroup::Straight < CardGroup::Base
  include CardGroup::Straightlike

  def valid?
    valid_straight?
  end
end
