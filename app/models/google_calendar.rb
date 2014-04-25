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
		GoogleCalendar.create_event(user.access_token, offer, agenda.google_code)
	end

	def self.create_event(access_token, offer, google_code)
		uri = URL_GOOGLE_CALENDAR+"calendars/#{google_code}/events?sendNotifications=true&fields=summary&description%2Cend%2Cstart&key=#{GOOGLE_API_KEY}"
		
		start_time =  ((Time.now) - (3.hours)).xmlschema
		end_time =   ((Time.now) - (3.hours) + (5.minutes).xmlschema
		
		data = {:end              => {:dateTime=> end_time},
				:start            => {:dateTime=> start_time},
				:summary          => "#{offer.twitter_message[0..(55 - offer.link.size)]}... #{offer.link}",
				:description      => offer.twitter_message}
		
		params = {}
		params[:access_token] = access_token
		params[:body] = data.to_json

		body = GoogleApi.post_json(uri, params)
		#formatando para hash
		GoogleApi.respond_to_hash(body)
		
	end
end