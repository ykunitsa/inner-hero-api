class ExposureSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  belongs_to :situation
  belongs_to :user
end
