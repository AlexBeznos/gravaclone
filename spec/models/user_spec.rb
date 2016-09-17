require 'rails_helper'
require 'sucker_punch/testing/inline'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:full_name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to have_many(:oauth_applications).class_name('ClientApplication').dependent(:destroy) }
  it { is_expected.to have_many(:footprints).dependent(:destroy) }

  context 'run callback on update' do
    let(:user) { create :user }

    User::TRACKED_ATTRS.each do |attribute|
      it "should receive send_user_update_callbacks when #{attribute} changed" do
        stubbed_user = build_stubbed :user
        expect(user).to receive(:send_user_update_callbacks)
        user.update(attribute => stubbed_user.send(attribute))
      end
    end
  end
end
