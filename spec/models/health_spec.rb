require 'rails_helper'

RSpec.describe Health, type: :model do
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:time) }
  it { should validate_presence_of(:value) }
end
