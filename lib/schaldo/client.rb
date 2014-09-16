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

  attr_accessor :guid

  def initialize(guid)
    @guid = guid
  end

  def topup
    if @topup.nil?
      @topup = Schaldo::Topup.new(self)
    end
    @topup
  end
end