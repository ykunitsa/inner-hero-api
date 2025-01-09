class SituationSerializer
  include JSONAPI::Serializer

  attributes :name, :description
end
