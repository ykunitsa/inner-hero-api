class Exposure < ApplicationRecord
  belongs_to :situation
  belongs_to :user
  has_many :exposure_steps, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true

  scope :for_user, ->(user) { where(user: user) }
end
