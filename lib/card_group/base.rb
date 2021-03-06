module CardGroup
  class Base
    attr_reader :cards

    def self.within?(cards:, **attrs)
      new(cards: cards, **attrs).valid?
    end

    def initialize(cards:, **_attrs)
      @cards = cards.clone
    end

    def high_value
      high_card.value
    end

    def size
      cards.size
    end

    private

    def high_card
      cards_sorted_by_value.first
    end

    def card_values
      cards.map(&:value)
    end

    def unique_values
      card_values.uniq
    end

    def num_unique_values
      unique_values.size
    end

    def cards_sorted_by_value
      cards.sort_by(&:value).reverse
    end

    def cards_with_value(val)
      cards.select { |card| card.value == val }
    end

    def card_value_decimal
      cards_sorted_by_value.map.with_index(1) do |card, i|
        card.value / (100.0 ** i)
      end.inject(&:+)
    end
  end
end
