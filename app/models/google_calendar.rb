require 'json'

class GoogleCalendar
	def self.list_agendas(access_token)
		#input
		uri = URL_GOOGLE_CALENDAR + "users/me/calendarList"
		params = {'access_token'=> access_token}
		body = GoogleApi.get(uri, params)
		#formatando para hash
		GoogleApi.respond_to_hash(body)
	end

	def self.test()
		user = User.first
		offer = Offer.last
		agenda = Agenda.last
		GoogleCalendar.create_event(user.access_token, offer, agenda)
	end

	def self.create_event(access_token, offer, agenda)
		uri = URL_GOOGLE_CALENDAR + "calendars/#{agenda.google_code}/events?sendNotifications=true&fields=summary&description%2Cend%2Cstart&key=#{GOOGLE_API_KEY}"
		
		start_time =  (Time.now).xmlschema
		end_time =   (Time.now + 5.minutes).xmlschema
		summary = "#{offer.link} #{offer.twitter_message[0..(62 - offer.link.size - agenda.name.size)]}..."
		
		data = {:end              => {:dateTime=> end_time},
				:start            => {:dateTime=> start_time},
				:summary          => summary,
				:description      => offer.twitter_message}
		
		params = {}
		params[:access_token] = access_token
		params[:body] = data.to_json

		body = GoogleApi.post_json(uri, params)
		#formatando para hash
		GoogleApi.respond_to_hash(body)
	end

	def self.create_calendar(access_token, name)
		uri = URL_GOOGLE_CALENDAR + "calendars?key=#{GOOGLE_API_KEY}"

		data = {:summary=>name}
		
		params = {}
		params[:access_token] = access_token
		params[:body] = data.to_json

		body = GoogleApi.post_json(uri, params)
		#formatando para hash
		GoogleApi.respond_to_hash(body)
	end
end