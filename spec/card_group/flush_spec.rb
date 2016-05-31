require "spec_helper"
require "card_group/flush"

describe CardGroup::Flush do
  it_behaves_like "card group"
  it_behaves_like "flush-like"
end
