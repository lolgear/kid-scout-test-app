require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:comment) { build :comment }
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_presence_of :post }
  its(:body) { is_expected.not_to be_empty }
end
