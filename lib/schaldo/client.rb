require "json"

class Schaldo::Client
  def initialize(guid)
    @guid = guid
  end

  def check_balance
    response = RestClient.post Schaldo::EXPLAIN_BALANCE_EP, {
      access_token: Schaldo.token,
      client_guid: @guid
    }
    JSON.parse response
  end
end