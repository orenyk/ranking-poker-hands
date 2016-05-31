require "card"
require "card_group"

class Hand < CardGroup::Base
  def initialize(card_strs:)
    @cards = card_strs.map { |card_str| Card.new(card_str: card_str) }
    @card_groups = []
    identify_groups
  end

  attr_accessor :cards, :card_groups

  def identify_groups
    return self if is_straight_flush?
    return self if is_four_of_a_kind?
  end

  def is_straight_flush?
    return false if num_card_groups > 1
    sf = if has_card_groups?
           card_groups.first
         else
           CardGroup::StraightFlush.new(cards: cards)
         end
    return false unless sf.valid?
    card_groups << sf unless has_card_groups?
    true
  end

  def is_four_of_a_kind?
    return false if num_card_groups > 2
    return false unless num_unique_values == 2
    foak = if has_card_groups?
             card_groups.select { |cg| cg.size == 4 }
           else
             CardGroup::NOfAKind.new(cards: cards, n: 4)
           end
    return false unless foak.valid?
    unless has_card_groups?
      card_groups << foak
      card_groups << remainder
    end
    true
  end

  def is_full_house?
    return false if num_card_groups > 2
    return false unless num_unique_values == 2

  end

  private

  def has_card_groups?
    !card_groups.empty?
  end

  def num_card_groups
    card_groups.length
  end

  def remainder
    CardGroup::HighCard.new(cards: leftovers)
  end

  def cards_not_currently_in_card_groups
    cards.reject { |card| cards_in_card_groups.include? card }
  end

  def cards_in_card_groups
    card_groups.collect { |cg| cg.cards }.flatten
  end
end
