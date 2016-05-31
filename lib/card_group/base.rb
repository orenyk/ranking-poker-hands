module CardGroup
  class Base
    def initialize(cards:)
      @cards = cards
    end

    def high_value
      high_card.value
    end

    def size
      cards.size
    end

    private

    attr_reader :cards

    def high_card
      cards_sorted_by_value.first
    end

    def card_values
      cards.map { |card| card.value }
    end

    def unique_values
      card_values.uniq
    end

    def num_unique_values
      unique_values.size
    end

    def cards_sorted_by_value
      cards.sort_by { |card| card.value }.reverse
    end
  end
end
