class Footprint < ApplicationRecord
  belongs_to :user
  belongs_to :application, class_name: 'ClientApplication'

  validates :user_id, :application_id, presence: true
  validates :user_id, uniqueness: [ :application_id ]
end
