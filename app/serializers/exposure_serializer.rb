class ExposureSerializer
  include JSONAPI::Serializer

  attributes :title, :description
end
