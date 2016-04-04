module RushHour
  class Server < Sinatra::Base
    helpers do
      def link_to_url(identifier, url)
        "<a href='/sources/#{identifier}/urls/#{URI.parse(url).path}'>#{url}</a>"
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


    post '/sources/:identifier/data' do |identifier|
      processor = PayloadProcessor.new(params[:payload], identifier)
      message = processor.process_payload
      status message[0]
      body message[1]
    end
  end
end
