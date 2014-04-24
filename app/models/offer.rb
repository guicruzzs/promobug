class Offer < ActiveRecord::Base
	has_many :schedules

	def self.verify
		puts "RUNNING OFFER.VERIFY at #{Time.now.to_s}"
		logger.debug "RUNNING OFFER.VERIFY at #{Time.now.to_s}"
		promobug = Twitter.user("hardmob_promo")
		promobug_text = promobug.attrs[:status][:text]
		puts "PROMO => #{promobug_text}"
		logger.debug "PROMO => #{promobug_text}"
		last_offer = Offer.last
		if last_offer.nil? or last_offer.twitter_message != promobug_text
			offer = Offer.new_promobug(promobug)
			puts "SIGNED => #{offer.inspect}"
			logger.debug "SIGNED => #{offer.inspect}"
			Interest.verify(offer)
		end
	end

	def self.new_promobug(promobug)
		offer = Offer.new(:twitter_message=>promobug.attrs[:status][:text],
						  :link=>promobug.attrs[:status][:entities][:urls].first[:url])
		offer.save
		offer
	end

	def verify_interest(interest)
		puts "INTEREST ID #{interest.id} ANALYSIS"
		if is_wanted?(interest) and !is_unwanted?(interest)
			puts "CREATE SCHEDULE"
			schedule = Schedule.insert(self, interest)
		end
	end

	def is_wanted?(interest)
		if interest.wanted_regexp.empty? 
			return true
		end
		self.twitter_message.underscore.match(eval interest.wanted_regexp)
	end

	def is_unwanted?(interest)
		if interest.unwanted_regexp.empty? 
			return false
		end
		self.twitter_message.underscore.match(eval interest.unwanted_regexp)
	end
end
