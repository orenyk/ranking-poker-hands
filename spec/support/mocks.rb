module Mocks
  def mock_card(val, suit)
    double("card").tap do |c|
      allow(c).to receive(:value).and_return(val)
      allow(c).to receive(:suit).and_return(suit)
    end
  end
end
