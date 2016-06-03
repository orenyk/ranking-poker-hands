require "spec_helper"
require "hand"

describe Hand do
  describe "#score" do
    it "adds up the scores of the included card groups" do
      cg1 = mock_card_group_with_score(10)
      cg2 = mock_card_group_with_score(15)
      allow(CardGroup::Parser).to receive(:parse).and_return([cg1, cg2])

      result = described_class.new(card_strs: []).score

      expect(result).to eq(25)
    end

    def mock_card_group_with_score(score)
      double("card_group").tap do |cg|
        allow(cg).to receive(:score).and_return(score)
      end
    end
  end
end
