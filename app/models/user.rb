class User < ApplicationRecord
  include Clearance::User

  has_many :oauth_applications, class_name: 'Doorkeeper::Application', as: :owner

  validates :first_name, :last_name, :full_name, presence: true
end
