module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    get '/' do
      erb :index
    end

    post '/sources' do
      client = Client.new(params)

      if client.save
        status 200
        message = {identifier: client.identifier}.to_json
        body message

      elsif params[:identifier].nil? || params[:rootUrl].nil?
        status 400
        body "#{client.errors.full_messages.join(', ')}"

      else #Client.find_by(:identifier => params[:client][:identifier])
        status 403
        body "#{client.errors.full_messages.join(', ')}"
      end
    end

    post '/sources/:identifier/data' do |identifier|
      processor = PayloadProcessor.new(params[:payload], identifier)
      message = processor.process_payload
      status message[0]
      body message[1]
    end

    get '/sources/:identifier' do |identifier|
      if !Client.exists?(identifier: identifier)
        error = "There is no account registered under this name.</p><p>Please register via curl request before proceeding."
        erb :error, locals: {error: error}

      elsif PayloadRequest.exists?(client_id: Client.find_by(identifier: identifier).id)
        @client = Client.find_by(identifier: identifier)
        erb :client_stats

      else
        error = "There are no payloads recorded for your account.</p><p>Please submit payloads via curl request to populate these statistics."
        erb :error, locals: {error: error}

      end
    end
  end
end
