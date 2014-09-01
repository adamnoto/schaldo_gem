require "json"

class Schaldo::Client
  def initialize(guid)
    @guid = guid
  end

  def explain_balance
    response = RestClient.get (Schaldo.config.server + Schaldo::BALANCE_EXPLAIN_EP), {
      params: {
        access_token: Schaldo.token,
        client_guid: @guid
      }
    }
    JSON.parse response
  end

  def topup(amount, author, note)
    raise "amount must be in number (eg. 1000, 100.85)" if (amount =~ /^[0-9\.]+$/).nil?
    amount = amount.to_f if amount.is_a?(String)

    response = RestClient.post (Schaldo.config.server + Schaldo::BALANCE_TOPUP_EP), {
      access_token: Schaldo.token,
      client_guid: @guid,
      amount: amount,
      author: author,
      note: note
    }

    JSON.parse response
  end
end