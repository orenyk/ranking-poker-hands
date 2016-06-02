require "card"
require "card_group"

class Hand < CardGroup::Base
  def initialize(card_strs:)
    @card_strs = card_strs
    @cards = extract_cards
    @card_groups = []
    identify_groups
  end

  attr_accessor :cards, :card_groups, :card_strs

  def score
    card_groups.reduce(0) { |score, cg| score + cg.score }
  end

  def is_straight_flush?
    has_or_is_group? :straight_flush
  end

  def is_four_of_a_kind?
    return false unless num_unique_values == 2
    has_or_is_partial_group? :n_of_a_kind, n: 4
  end

  def is_full_house?
    has_or_is_group? :full_house
  end

  def is_flush?
    has_or_is_group? :flush
  end

  def is_straight?
    has_or_is_group? :straight
  end

  def is_three_of_a_kind?
    return false unless num_unique_values == 3
    has_or_is_partial_group? :n_of_a_kind, n: 3
  end

  def is_two_pair?
    return false unless num_unique_values == 3
    has_or_is_partial_group? :two_pair, n: 4
  end

  def is_one_pair?
    return false unless num_unique_values == 4
    has_or_is_partial_group? :n_of_a_kind, n: 2
  end

  private

  attr_accessor :primary_group

  def identify_groups
    return self if is_straight_flush?
    return self if is_four_of_a_kind?
    return self if is_full_house?
    return self if is_flush?
    return self if is_straight?
    return self if is_three_of_a_kind?
    return self if is_two_pair?
    return self if is_one_pair?
    convert_to_high_card
  end

  def convert_to_high_card
    card_groups << CardGroup::HighCard.new(cards: cards) unless has_card_groups?
  end

  def has_card_groups?
    !card_groups.empty?
  end

  def num_card_groups
    card_groups.length
  end

  def remainder
    @remainder ||= CardGroup::HighCard.new(cards: leftovers)
  end

  def leftovers
    cards.reject { |card| primary_group.cards.include? card }
  end

  def has_or_is_group?(group_name)
    return false if num_card_groups > 1
    group = if has_card_groups?
              card_groups.first
            else
              group_class(group_name).send(:new, cards: cards)
            end
    return false unless group.valid?
    card_groups << group unless has_card_groups?
    true
  end

  def has_or_is_set?(size)
    return false if num_card_groups > 2
    group = if has_card_groups?
              primary_group
            else
              find_set(size)
            end
    return false unless group.valid?
    unless has_card_groups?
      primary_group = group
      card_groups << primary_group
      card_groups << remainder
    end
    true
  end

  def has_or_is_partial_group?(group_name, attr = { n: 0 })
    return false if num_card_groups > 2
    group = if has_card_groups?
              card_groups.select { |cg| cg.size == attr[:n] }.first
            else
              group_class(group_name).send(:new, attr.merge(cards: cards))
            end
    return false unless group.valid?
    unless has_card_groups?
      card_groups << group
      card_groups << remainder
    end
    true
  end

  def find_set(size)
    unique_values.each do |val|
      test_cards = cards_with_value(val)
      next if test_cards.length != size
    end
    CardGroup::NOfAKind.new(cards: test_cards, n: size)
  end

  def group_class(group_name)
    Object.const_get("CardGroup::#{camelize(group_name)}")
  end

  def camelize(sym)
    sym.to_s.split("_").map(&:capitalize).join
  end

  def extract_cards
    card_strs.map { |card_str| Card.new(card_str: card_str) }
  end
end
