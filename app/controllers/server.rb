module RushHour
  class Server < Sinatra::Base
    helpers do
      def link_to_url(identifier, url)
        "<a href='/sources/#{identifier}/urls/#{url.match(/\b\/\K\S+/)[0]}'>#{url}</a>"
      end

      def link_to_event(identifier, event)
        "<a href='/sources/#{identifier}/events/#{event}'>#{event}</a>"
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
        body "#{client.errors.full_messages.join(', ')}. "

      else #Client.find_by(:identifier => params[:client][:identifier])
        status 403
        body "#{client.errors.full_messages.join(', ')}. "
      end
    end

    post '/sources/:identifier/data' do |identifier|
      processor = PayloadProcessor.new(params[:payload], identifier)
      message = processor.process_payload
      status message[0]
      body message[1]
    end
  end
end
