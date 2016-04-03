module RushHour
  class Server < Sinatra::Base
    get '/sources/:identifier/urls/:relativepath' do |identifier, relativepath|

      @url = Url.find_by(url: build_client_url(identifier, relativepath))

      if @url.nil?
        error = "Sorry, this Url is not associated with your account. "
        erb :error, locals: {error: error}

      else
        erb :show_url

      end
    end
  end
end
