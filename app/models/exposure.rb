class Exposure < ApplicationRecord
  belongs_to :situation
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true

  scope :for_user, ->(user) { where(user: user) }
end
