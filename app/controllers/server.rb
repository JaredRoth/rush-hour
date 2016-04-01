module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    get '/' do
      erb :index
    end

    post '/sources' do
      client = Client.new(params[:client])

      if client.save
        status 200
        body "{'identifier':'#{client.identifier}'}"

      elsif params[:client][:identifier].nil? || params[:client][:rootUrl].nil?
        status 400
        body "#{client.errors.full_messages.join(',')}"

      else #Client.find_by(:identifier => params[:client][:identifier])
        status 403
        body "#{client.errors.full_messages.join(',')}"
      end
    end
  end
end
