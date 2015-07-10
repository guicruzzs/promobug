class Api::InterestsController < Api::ApplicationController
	before_filter :authenticate
	def new
		interest = Interest.new(
			:user_id => @user.id,
			:wanted_regexp => params["wanted_regexp"],
			:unwanted_regexp => params["unwanted_regexp"],
			:status => Interest::ACTIVE_STATUS
		)

		if interest.save
			@user.interests.active.each do |user_active_interest|
				user_active_interest.inactivate if user_active_interest.id != interest.id
			end
			respond_to_api(parse_data(interest))
		else
			respond_to_api(interest)
		end
	end

	def get
		interest = Interest.where(
			:id => params["id"],
			:user_id => @user.id,
			:status => Interest::ACTIVE_STATUS
		).last

		if interest.nil?
			interest = Interest.new
			interest.errors.add(:id, I18n.translate("errors.messages.invalid"))
			respond_to_api(interest)
		else
			respond_to_api(parse_data(interest))
		end
	end

	def list
		data_response = []
		@user.interests.each do |interest|
			data_response << parse_data(interest)
		end
		respond_to_api(data_response)
	end

	private
	def parse_data(interest)
		{
			:user_id => interest.user_id,
			:wanted => interest.wanted,
			:unwanted => interest.unwanted,
			:wanted_regexp => interest.wanted_regexp,
			:unwanted_regexp => interest.unwanted_regexp,
			:status => interest.status
		}
	end
end