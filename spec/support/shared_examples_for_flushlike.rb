shared_examples_for "flush-like" do
  describe "#valid" do
    it "returns true if there are five cards with identical suits" do
      cards = [mock_card(2, "H"), mock_card(3, "H"), mock_card(8, "H"),
               mock_card(5, "H"), mock_card(10, "H")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_truthy
    end

    it "returns false if there are five cards without identical suits" do
      cards = [mock_card(2, "H"), mock_card(3, "S"), mock_card(8, "H"),
               mock_card(5, "H"), mock_card(10, "H")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_falsey
    end

    it "returns true if there aren't five cards" do
      cards = [mock_card(2, "H"), mock_card(3, "H"), mock_card(8, "H"),
               mock_card(5, "H")]

      result = described_class.new(cards: cards).valid?

      expect(result).to be_falsey
    end
  end
end
