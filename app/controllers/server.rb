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

    post '/sources/:IDENTIFIER/data' do |identifier|
      require 'pry'; binding.pry
      parsed_payload = JSON.parse(params[:payload_request][:payload])

      ip                = Ip.find_or_create_by(:ip => params[:payload_request][:payload][:ip])
      resolution        = Resolution.find_or_create_by(:resolution_width => params[:payload_request][:payload][:resolutionWidth], :resolution_height => params[:payload_request][:payload][:resolutionHeight])
      user_agent_string = UserAgentString.find_or_create_by(:user_agent_os => UserAgent.parse(params[:payload_request][:payload][:userAgent]).platform, :user_agent_browser => UserAgent.parse(params[:payload_request][:payload][:userAgent]).browser)
      event             = Event.find_or_create_by(:event_name => params[:payload_request][:payload][:eventName])
      request_type      = RequestType.find_or_create_by(:request_type => params[:payload_request][:payload][:requestType])
      referrer          = Referrer.find_or_create_by(:referred_by => params[:payload_request][:payload][:referredBy])
      url               = Url.find_or_create_by(:url => params[:payload_request][:payload][:url])
      client            = Client.find_or_create_by(:identifier => params[:payload_request][:payload][:identifier], :rootUrl => params[:payload_request][:payload][:rootUrl])

      PayloadRequest.new(
      :requested_at         => params[:payload_request][:payload][:requestedAt],
      :responded_in         => params[:payload_request][:payload][:respondedIn],
      :ip_id                => ip.id,
      :resolution_id        => resolution.id,
      :user_agent_string_id => user_agent_string.id,
      :event_id             => event.id,
      :request_type_id      => request_type.id,
      :referrer_id          => referrer.id,
      :url_id               => url.id,
      :client_id            => client.id
      )

      if client.save
        status 200
        # body "{'identifier':'#{client.identifier}'}"

      elsif params[:payload_request][:payload].nil?
        status 400
        body "#{client.errors.full_messages.join(',')}"

      elsif Client.where(identifier: identifier).any? == false
        status 403
        body "#{client.errors.full_messages.join(',')}"

      else #Client.find_by(:identifier => params[:client][:identifier])
        status 403
        body "#{client.errors.full_messages.join(',')}"
      end
    end
  end
end
