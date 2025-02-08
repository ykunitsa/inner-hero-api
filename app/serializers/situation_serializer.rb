class SituationSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_many :exposures
end
