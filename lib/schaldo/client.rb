require "json"

class Schaldo::Client
  class << self
    def register_new(name)
      response = RestClient.post (Schaldo.config.server + Schaldo::COMPANY_CLIENT_REGISTER_NEW), {
        access_token: Schaldo.token,
        name: name.to_s
      }
      response = JSON.parse(response)
      response["client_guid"]
    end
  end

  def initialize(guid)
    @guid = guid
  end

  def balance
    response = RestClient.get (Schaldo.config.server + Schaldo::BALANCE_CLIENT_INDEX_EP), {
      params: {
        access_token: Schaldo.token,
        client_guid: @guid
      }
    }
    response = JSON.parse(response)
    response["balance"]
  end

  def explain_balance
    response = RestClient.get (Schaldo.config.server + Schaldo::BALANCE_CLIENT_EXPLAIN_EP), {
      params: {
        access_token: Schaldo.token,
        client_guid: @guid
      }
    }
    JSON.parse response
  end

  def topup_balance(amount, author, note)
    raise "amount must be in number (eg. 1000, 100.85)" if (amount =~ /^[0-9\.]+$/).nil?
    amount = amount.to_f if amount.is_a?(String)

    response = RestClient.post (Schaldo.config.server + Schaldo::BALANCE_CLIENT_TOPUP_EP), {
      access_token: Schaldo.token,
      client_guid: @guid,
      amount: amount,
      author: author,
      note: note
    }

    JSON.parse response
  end

  def topup_detail(guid)
    response = RestClient.get (Schaldo.config.server + SchaldO::BALANCE_CLIENT_TOPUP_DETAIL_EP), {
      params: {
        access_token: Schaldo.token,
        client_guid: @guid,
        topup_guid: guid
      }
    }

    JSON.parse response
  end

  def balance_waiting_verification
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