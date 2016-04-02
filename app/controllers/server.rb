module RushHour
  class Server < Sinatra::Base
    helpers do
      def link_to(identifier, relativepath, title)
        "<a href='/sources/#{identifier}/urls/#{relativepath}'>#{title}</a>"
      end

      def client_url_path(url)
         url.match(/\w+\z/)[0]
      end

      def build_client_url(identifier, relativepath)
        "http://#{identifier}.com/#{relativepath}"
      end
    end

    not_found do
      error = "Page not found"
      erb :error, locals: {error: error}
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
        error = "Sorry, no account registered under this name.</p><p>Please register via curl request before proceeding."
        erb :error, locals: {error: error}

      elsif PayloadRequest.exists?(client_id: Client.find_by(identifier: identifier).id)
        @client = Client.find_by(identifier: identifier)
        erb :client_stats, locals: {identifier: identifier}

      else
        error = "Sorry, no payloads associated with your account.</p><p>Please submit payloads via curl request to populate these statistics."
        erb :error, locals: {error: error}

      end
    end

    get '/sources/:identifier/urls/:relativepath' do |identifier, relativepath|

      @url = Url.find_by(url: build_client_url(identifier, relativepath))

      if @url.nil?
        error = "Sorry, No Urls Associated With Your Account"
        erb :error, locals: {error: error}

      else

        erb :show_url
      end
    end
  end
end
