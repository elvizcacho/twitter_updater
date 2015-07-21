class Clients

  def initialize
    
    clients = []

    clients << Twitter::REST::Client.new do |config|
      config.consumer_key        = ""
      config.consumer_secret     = ""
      config.access_token        = ""
      config.access_token_secret = ""
    end

    @clients = clients
  end

  def clients
    @clients
  end
  
end