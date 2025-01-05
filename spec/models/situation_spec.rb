require 'rails_helper'

RSpec.describe Situation, type: :model do
  it { should validate_presence_of(:name) }
end
