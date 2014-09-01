require "json"

class Schaldo::Client
  def initialize(guid)
    @guid = guid
  end

  def explain_balance
    response = RestClient.get (Schaldo.config.server + Schaldo::EXPLAIN_BALANCE_EP), {
      access_token: Schaldo.token,
      client_guid: @guid
    }
    JSON.parse response
  end
end