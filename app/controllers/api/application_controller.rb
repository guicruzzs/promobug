class Api::ApplicationController < ApplicationController

	def authenticate
		if params["authentication_token"] && !User.where(:authentication_token=> params["authentication_token"]).first.nil?
			return true
		else
			user = User.new
			user.errors.add(:authentication_token, I18n.translate("errors.messages.invalid"))
			respond_to_api(user)
			return false
		end
	end

	def respond_to_api(data)
		api_response = {
			:success => !(data.respond_to?(:errors) && !data.errors.empty?)
		}

		if api_response[:success]
			api_response[:data_response] = data
		else
			api_response[:data_response] = {:errors => data.errors}
		end

		render :json => api_response
	end

end