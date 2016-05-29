require "card_group"

class NOfAKind < CardGroup
  def valid?
    num_unique_values == 1
  end

  private

  def card_values
    cards.map { |card| card[:value] }
  end

  def num_unique_values
    card_values.uniq.length
  end
end
