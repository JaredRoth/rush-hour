require 'digest/sha1'

class PayloadProcessor
  attr_reader :parsed_payload, :identifier, :payload_sha

  def initialize(json_payload, identifier)
    if json_payload.nil?
      @payload_sha = nil
      @parsed_payload = {}
    else
      @payload_sha = Digest::SHA1.hexdigest(json_payload)
      @parsed_payload = JSON.parse(json_payload, symbolize_names: true)
    end
    @identifier = identifier
  end

  def process_payload
    payload = create_payload
    if payload.save
      [200, "Your submission was successful. "]

    elsif parsed_payload.empty?
      [400, "#{payload.errors.full_messages.join(', ')}. "]

    elsif !Client.exists?(identifier: identifier)
      [403, "Client is not registered. "]

    else #PayloadRequest.exists?(payload_sha: Digest::SHA1.hexdigest(json_payload))
      [403, "#{payload.errors.full_messages.join(', ')}. "]
    end
  end

  def create_payload
    ip                = Ip.where(ip: parsed_payload[:ip]).first_or_create
    resolution        = Resolution.where(resolution_width: parsed_payload[:resolutionWidth], resolution_height: parsed_payload[:resolutionHeight]).first_or_create
    user_agent_string = UserAgentString.where(user_agent_os: UserAgent.parse(parsed_payload[:userAgent]).platform, user_agent_browser: UserAgent.parse(parsed_payload[:userAgent]).browser).first_or_create
    event             = Event.where(event_name: parsed_payload[:eventName]).first_or_create
    request_type      = RequestType.where(request_type: parsed_payload[:requestType]).first_or_create
    referrer          = Referrer.where(referred_by: parsed_payload[:referredBy]).first_or_create
    url               = Url.where(url: parsed_payload[:url]).first_or_create
    client            = Client.where(identifier: identifier).first_or_create

    PayloadRequest.new(
    :requested_at         => parsed_payload[:requestedAt],
    :responded_in         => parsed_payload[:respondedIn],
    :payload_sha          => payload_sha,
    :ip_id                => ip.id,
    :resolution_id        => resolution.id,
    :user_agent_string_id => user_agent_string.id,
    :event_id             => event.id,
    :request_type_id      => request_type.id,
    :referrer_id          => referrer.id,
    :url_id               => url.id,
    :client_id            => client.id
    )
  end
end
