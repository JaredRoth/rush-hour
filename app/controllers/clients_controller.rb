module RushHour
  class ClientsController < Server

    post '/sources' do
      client_loader = ClientLoader.new(params).create
      status client_loader.status[:status]
      body client_loader.body
    end
    
    get '/sources/:identifier' do |identifier|
      if !Client.exists?(identifier: identifier)
        error = "Sorry, no account registered under this name.</p>
              <p>Please register via curl request before proceeding. "
        erb :error, locals: {error: error}

      elsif PayloadRequest.exists?(client_id: Client.find_by(identifier: identifier).id)
        @client = Client.find_by(identifier: identifier)
        erb :client_stats, locals: {identifier: identifier}

      else
        error = "Sorry, no payloads associated with your account.</p>
              <p>Please submit payloads via curl request to populate these statistics. "
        erb :error, locals: {error: error}

      end
    end
  end
end
