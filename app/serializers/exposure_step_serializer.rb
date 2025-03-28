class ExposureStepSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :duration
  belongs_to :exposure
end
