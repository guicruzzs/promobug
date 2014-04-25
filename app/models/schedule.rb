class Schedule < ActiveRecord::Base
  belongs_to :interest
  belongs_to :offer

  def self.insert(offer, interest)
  	schedule = Schedule.new(:offer_id=>offer.id, :interest_id=>interest.id)
  	schedule.save
	
	puts "CREATE ON GOOGLE CALENDAR"
	agenda = interest.agenda
	user = agenda.user
	
	user.check_token_expiration
	user = agenda.user
	
	GoogleCalendar.create_event(user.access_token, offer, agenda)
	puts "SCHEDULING'S END"
  end
end
