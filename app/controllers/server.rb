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
        body "{'identifier':'#{client.identifier}'}"

      elsif params[:identifier].nil? || params[:rootUrl].nil?
        status 400
        body "#{client.errors.full_messages.join(', ')}"

      else #Client.find_by(:identifier => params[:client][:identifier])
        status 403
        body "#{client.errors.full_messages.join(', ')}"
      end
    end

    post '/sources/:identifier/data' do |identifier|
      # parsed_payload = params[:payload] && params[:payload].length >= 2 ? JSON.parse(params[:payload], symbolize_names: true) : nil
      # parsed_payload = JSON.parse(params[:payload], symbolize_names: true)
      # parsed_payload = params[:payload]

      ip                = Ip.find_or_create_by(:ip => parsed_payload[:ip])
      resolution        = Resolution.find_or_create_by(:resolution_width => parsed_payload[:resolutionWidth], :resolution_height => parsed_payload[:resolutionHeight])
      user_agent_string = UserAgentString.find_or_create_by(:user_agent_os => UserAgent.parse(parsed_payload[:userAgent]).platform, :user_agent_browser => UserAgent.parse(parsed_payload[:userAgent]).browser)
      event             = Event.find_or_create_by(:event_name => parsed_payload[:eventName])
      request_type      = RequestType.find_or_create_by(:request_type => parsed_payload[:requestType])
      referrer          = Referrer.find_or_create_by(:referred_by => parsed_payload[:referredBy])
      url               = Url.find_or_create_by(:url => parsed_payload[:url])
      client            = Client.find_or_create_by(:identifier => identifier, :rootUrl => parsed_payload[:referredBy])

      payload = PayloadRequest.new(
      :requested_at         => parsed_payload[:requestedAt],
      :responded_in         => parsed_payload[:respondedIn],
      :ip_id                => ip.id,
      :resolution_id        => resolution.id,
      :user_agent_string_id => user_agent_string.id,
      :event_id             => event.id,
      :request_type_id      => request_type.id,
      :referrer_id          => referrer.id,
      :url_id               => url.id,
      :client_id            => client.id
      )

      if params[:payload].nil?
        status 400
        body "#{payload.errors.full_messages.join(', ')}"

      elsif Client.where(identifier: identifier).any?
        status 403
        body "#{payload.errors.full_messages.join(', ')}"

      elsif payload.save
        status 200
        # body "{'identifier':'#{payload.identifier}'}"

      else
        status 403
        body "#{payload.errors.full_messages.join(', ')}"
      end
    end
  end
end
