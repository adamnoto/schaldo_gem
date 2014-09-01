require "schaldo/version"
require "active_support/configurable"

module Schaldo
  include ActiveSupport::Configurable

  TOKEN_RENEWAL_EP = "/oauth/token"
  BALANCE_EXPLAIN_EP = "/api/v1/balance/client/explain"
  BALANCE_TOPUP_EP = "/api/v1/balance/client/topup"

  module_function
  def token
    if @token == nil || (Time.now.to_i + 100) > @token_expired_time
      response = RestClient.post (Schaldo.config.server + Schaldo::TOKEN_RENEWAL_EP), {
          grant_type: "client_credentials",
          client_id: Schaldo.config.app_id,
          client_secret: Schaldo.config.secret_id
      }
      response = JSON.parse(response)

      @token = response["access_token"]
      @token_expired_time = Time.now.to_i + Integer(response["expires_in"])
    end
    @token
  end

  class << self
    def setup
      config.app_id = ""
      config.secret_id = ""
      config.server ||= "http://localhost:4002"
      yield config
    end
  end
end

require "schaldo/client"