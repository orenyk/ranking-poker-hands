require "card_group/base"
require "card_group/straightlike"

class CardGroup::Straight < CardGroup::Base
  include CardGroup::Straightlike

  def valid?
    valid_straight?
  end

  def score
    return 0 unless valid?
    return 5 * 15**4 if aces_low_straight?
    high_value * 15**4
  end
end
