module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    def clients_url(identifier)
      @client = Client.find_by(identifier: identifier)
      helpers do
        "<a href='#{:identifier}/urls/#{:relative_path}'>#{@client.capitalize} Urls</a>"
      end
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
        error = "Not registered"
        erb :error, locals: {error: error}

      elsif PayloadRequest.exists?(client_id: Client.find_by(identifier: identifier).id)
        @client = Client.find_by(identifier: identifier)
        erb :client_stats

      else
        error = "No payloads"
        erb :error, locals: {error: error}

      end

    get '/sources/:identifier/urls/:relative_path' do |identifier|
      if !Client.exists?(identifier: identifier)
        error = "Not registered"
        erb :error, locals: {error: error}

      elsif PayloadRequest.exists?(client_id: Client.find_by(identifier: identifier).id)
        @relative_path = Client.find_by(identifier: identifier).where(relative_path: relative_path)
        erb :clients_specific_url_stats

      else
        error = "Sorry, No Urls Associated With Your Account"
        erb :error, locals: {error: error}
      end
    end
  end
end
