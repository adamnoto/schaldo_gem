require "json"

class Schaldo::Topup
  def initialize(client)
    @client = client
    raise "client must be an instance of Schaldo::Client" unless client.is_a?(Schaldo::Client)
  end

  def list_topups_at(d, m, y)
    response = RestClient.get (Schaldo.config.server + Schaldo::BALANCE_CLIENT_TOPUP_LIST_BY_DMY), {
      params: {
        access_token: Schaldo.token,
        client_guid: @client.guid
      }
    }
    response = JSON.parse(response)
    response
  end

  # get the balance detail of the client identified by the guid
  def balance
    response = RestClient.get (Schaldo.config.server + Schaldo::BALANCE_CLIENT_INDEX_EP), {
        params: {
            access_token: Schaldo.token,
            client_guid: @client.guid
        }
    }
    response = JSON.parse(response)
    response["balance"]
  end

  # list balance history
  def explain_balance
    response = RestClient.get (Schaldo.config.server + Schaldo::BALANCE_CLIENT_EXPLAIN_EP), {
        params: {
            access_token: Schaldo.token,
            client_guid: @client.guid
        }
    }
    JSON.parse response
  end

  # perform topup.
  # day_as_integer = 1..31
  # m_as_integer = 1..12, 1 is January, to 12 is December
  # y_as_integer must be greater than 1800
  def topup_balance(day_as_integer, m_as_integer, y_as_integer, amount, author, note)
    raise "amount must be in number (eg. 1000, 100.85)" if (amount =~ /^[0-9\.]+$/).nil?
    raise "day must be an integer between 1..31" unless (1..31).include?(day_as_integer)
    raise "month must be an integer between 1..12" unless (1..12).include?(m_as_integer)
    raise "year must be greater than 1800" unless y_as_integer > 1800

    amount = amount.to_f if amount.is_a?(String)

    response = RestClient.post (Schaldo.config.server + Schaldo::BALANCE_CLIENT_TOPUP_EP), {
      access_token: Schaldo.token,
      client_guid: @client.guid,
      amount: amount,
      author: author,
      note: note,
      d: day_as_integer,
      m: m_as_integer,
      y: y_as_integer
    }

    JSON.parse response
  end

  def topup_detail(topup_guid)
    response = RestClient.get (Schaldo.config.server + Schaldo::BALANCE_CLIENT_TOPUP_DETAIL_EP), {
        params: {
            access_token: Schaldo.token,
            client_guid: @client.guid,
            topup_guid: topup_guid
        }
    }

    JSON.parse response
  end
end