require 'rails_helper'

RSpec.describe Footprint, type: :model do
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:application_id) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:application).class_name("ClientApplication") }
end
