# frozen_string_literal: true

module RequestHelpers
  def parse_error_message(response)
    JSON.parse(response.body)['data']['errors']['detail']
  end
end
