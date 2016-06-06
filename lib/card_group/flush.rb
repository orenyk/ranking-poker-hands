require "card_group/base"
require "card_group/flushlike"

class CardGroup::Flush < CardGroup::Base
  include CardGroup::Flushlike

  def valid?
    valid_flush?
  end

  # We multiply the card value decimal by 100 so that base value is the highest
  # card, e.g. 14.13040302 for [A, K, 4, 3, 2]
  def score
    return 0 unless valid?
    100 * card_value_decimal * 15 ** 5
  end
end
