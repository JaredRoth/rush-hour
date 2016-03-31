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
        body "{\"identifier\":\"#{client.identifier}\"}"

      elsif Client.exists?(:identifier => params[:identifier])
        status 403
        body "#{client.errors.full_messages.join(',')}"

      else #params[:identifier].nil? || params[:rootUrl].nil?
        status 400
        body "#{client.errors.full_messages.join(',')}"
      end
    end
  end
end
