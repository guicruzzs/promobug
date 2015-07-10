class Api::ApplicationController < ApplicationController
	@user = nil
	def authenticate
		if params["authentication_token"] 
			@user = User.get_by_token(params["authentication_token"])
			if !@user.nil?
				return true
			end
		end
		
		user = User.new
		user.errors.add(:authentication_token, I18n.translate("errors.messages.invalid"))
		respond_to_api(user)
		return false
		
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