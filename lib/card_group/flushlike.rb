module CardGroup::Flushlike
  def valid_flush?
    num_unique_suits == 1 && size == 5
  end

  private

  def card_suits
    cards.map(&:suit)
  end

  def num_unique_suits
    card_suits.uniq.length
  end
end
