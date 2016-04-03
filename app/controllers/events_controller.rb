module RushHour
  class Server < Sinatra::Base

    get '/sources/:identifier/events/:eventname' do |identifier, eventname|
      @event = Event.find_by(event_name: eventname)

      if @event.nil?
        error = "Sorry, No Events Associated With Your Account. </p>
      <p><a href='/sources/#{identifier}'>Click here to see your available events.</a>"
        erb :error, locals: {error: error}

      else
        hours_hash = @event.hourly_requests
        erb :show_event, locals: {hours_hash: hours_hash}

      end
    end
  end
end
