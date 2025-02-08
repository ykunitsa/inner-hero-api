class ExposureStep < ApplicationRecord
  belongs_to :exposure

  validates :title, presence: true
  validates :duration, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
