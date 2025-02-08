require 'rails_helper'

RSpec.describe ExposureStep, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_numericality_of(:duration).is_greater_than_or_equal_to(0) }
end
