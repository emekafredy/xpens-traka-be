# frozen_string_literal: true

class ApplicationSerializer
  include JSONAPI::Serializer

  set_key_transform :camel_lower
  def serialized_response
    serializable_hash.to_json
  end
end
