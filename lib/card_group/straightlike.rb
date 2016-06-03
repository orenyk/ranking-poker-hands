module CardGroup::Straightlike
  def valid_straight?
    aces_low_straight? || (ordered_values == expected_straight && size == 5)
  end

  private

  def ordered_values
    card_values.sort
  end

  def expected_straight
    ((high_value - 4)..high_value).to_a
  end

  def aces_low_straight?
    ([2, 3, 4, 5, 14] - card_values).empty?
  end
end
