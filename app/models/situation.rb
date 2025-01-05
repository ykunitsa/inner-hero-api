class Situation < ApplicationRecord
  validates :name, presence: true

  has_many :exposures
end
