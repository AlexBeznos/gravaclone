class User < ApplicationRecord
  include Clearance::User

  validates :first_name, :last_name, :full_name, presence: true
end
