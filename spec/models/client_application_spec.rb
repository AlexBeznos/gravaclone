require 'rails_helper'

RSpec.describe ClientApplication, type: :model do
  it { is_expected.to have_many(:footprints).with_foreign_key(:application_id).dependent(:destroy) }
end
