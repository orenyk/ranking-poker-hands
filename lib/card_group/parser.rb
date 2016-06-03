require "card_group"

class CardGroup::Parser < CardGroup::Base
  HANDS = [:straight_flush, :four_of_a_kind, :full_house, :flush, :straight,
           :three_of_a_kind, :two_pair, :one_pair].freeze
  CLASSES = [:straight_flush, :full_house, :flush, :straight,
                :two_pair].freeze
  SETS = { four_of_a_kind: 4, three_of_a_kind: 3, one_pair: 2 }.freeze

  attr_accessor :card_groups

  def self.parse(cards:, **attrs)
    new(cards: cards, **attrs).parse
  end

  def initialize(cards:, **_attrs)
    super
    @card_groups = []
  end

  def parse
    HANDS.each do |hand|
      if CLASSES.include? hand
        if is_card_group? hand
          card_groups << group_class(hand).new(cards: cards)
          break
        end
      else
        if is_card_group? :n_of_a_kind, n: SETS[hand]
          card_groups << group_class(:n_of_a_kind)
            .new(cards: cards, n: SETS[hand])
          break
        end
      end
    end
    card_groups << remainder unless remainder.nil?
    card_groups
  end

  private

  def remainder
    return CardGroup::HighCard.new(cards: cards) if card_groups.empty?
    return nil if full_hand?
    CardGroup::HighCard.new(cards: remaining_cards)
  end

  def full_hand?
    primary_group_cards.length == 5
  end

  def remaining_cards
    cards.reject { |c| primary_group_cards.include? c }
  end

  def primary_group_cards
    card_groups.first.cards
  end

  def is_card_group?(group_name, attr = {})
    group_class(group_name).within?(cards: cards, **attr)
  end

  def group_class(group_name)
    Object.const_get("CardGroup::#{camelize(group_name)}")
  end

  def camelize(sym)
    sym.to_s.split("_").map(&:capitalize).join
  end
end
