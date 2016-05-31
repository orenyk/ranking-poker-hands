require "card_group/base"
require "card_group/n_of_a_kind"

class CardGroup::FullHouse < CardGroup::Base
  def initialize(cards:)
    super
    parse_out_sets
  end

  def valid?
    has_three_of_a_kind? && has_pair?
  end

  def score
    return 0 unless valid?
    high_value * 15**6
  end

  private

  attr_accessor :three_of_a_kind, :pair

  def parse_out_sets
    return self if num_unique_values != 2

    unique_values.each do |val|
      cards = cards_with_value(val)
      return self unless [2, 3].include? cards.length

      if cards.length == 3
        @three_of_a_kind = generate_set(cards)
      elsif cards.length == 2
        @pair = generate_set(cards)
      end
    end
  end

  def has_three_of_a_kind?
    three_of_a_kind && three_of_a_kind.valid?
  end

  def has_pair?
    pair && pair.valid?
  end

  def generate_set(cards)
    CardGroup::NOfAKind.new(cards: cards, n: cards.length)
  end
end
