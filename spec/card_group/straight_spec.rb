require "spec_helper"
require "card_group/straight"

describe CardGroup::Straight do
  it_behaves_like "card group"
  it_behaves_like "straight-like"
end
