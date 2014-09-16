require "json"

# Schaldo::ServicedCompany deal with the company that uses the API.
# ServicedCompany is the user that register their app, and use the service of Schaldo.
# ServicedCompany usually have more than one clients, on which the client perform top up balance,
# and on which ServicedCompany administer those top ups.

module Schaldo::ServicedCompany
  module_function

  def change_topup_status(topup_guid, status, verifier)
    statsym = status.downcase.to_sym
    raise "status must either be verified/canceled, yours: #{statsym}" unless [:verified, :canceled].include?(statsym)
    raise "verifier cannot be nil, you can assign name or your user id" if verifier.blank?

    response = RestClient.post (Schaldo.config.server + Schaldo::BALANCE_CLIENT_TOPUP_CHANGE_STATUS_EP), {
      access_token: Schaldo.token,
      client_guid: @guid,
      topup_guid: topup_guid,
      verifier: verifier,
      status: status
    }

    JSON.parse response
  end

  def topup_waiting_verification
    response = RestClient.get (Schaldo.config.server + Schaldo::BALANCE_CLIENT_WAITING_EP), {
      params: {
        access_token: Schaldo.token,
        # actually doesn't really matter since guid of the client is not basically needed
        # but since the API requires client_guid for the whole namespace, we need to attach it.
        client_guid: @guid
      }
    }

    JSON.parse response
  end
end