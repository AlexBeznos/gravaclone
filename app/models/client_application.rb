class ClientApplication < Doorkeeper::Application
  has_many :footprints, foreign_key: :application_id, dependent: :destroy
  validates :user_update_url, url: true, allow_nil: true, allow_blank: true
end
