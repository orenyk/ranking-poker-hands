require "hand"

class HandEvaluator
  def return_stronger_hand(left, right)
    left_hand = Hand.new(card_strs: left)
    right_hand = Hand.new(card_strs: right)

    return left_hand.card_strs if left_hand.score > right_hand.score
    return right_hand.card_strs if right_hand.score > left_hand.score
    fail ArgumentError, "The hands are tied"
  end
end
