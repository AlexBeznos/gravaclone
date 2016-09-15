class User < ApplicationRecord
  TRACKED_ATTRS = ['first_name', 'last_name', 'full_name', 'email']
  include Clearance::User

  has_many :oauth_applications, class_name: 'ClientApplication', as: :owner, dependent: :destroy
  has_many :footprints, dependent: :destroy
  validates :first_name, :last_name, :full_name, presence: true
  after_update :send_user_update_callbacks, if: :changed?

  private

  def send_user_update_callbacks
    tracked_changes = changes.select { |k,v| TRACKED_ATTRS.include? k }

    if tracked_changes.any?
      SetupWalkThroughFootprintsJob.perform_async(id, tracked_changes)
    end
  end
end
