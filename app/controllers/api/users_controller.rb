class Api::UsersController < Api::ApplicationController

	# The :gcm_registration_code must be added, including DB modifications
	def login
		user = User.where(:email=>params["email"]).first
    	if user && user.valid_password?(params[:password])
	        sign_in user
	        user.reset_authentication_token!
	        # user.register_gcm(params[:gcm_registration_code])
	        respond_to_api(parse_data(user))
	      else
	      	if user.nil?
	      		user = User.new
	      	end
	        user.errors.add(:login, I18n.translate("errors.messages.invalid"))
	        respond_to_api(user)
	      end
	end

	def sign_up
		user = User.create(
			:email => params["email"],
			:password => params["password"],
			:password_confirmation => params["password_confirmation"]
		)
		if user.id
			sign_in(user)
			user.ensure_authentication_token!
			respond_to_api(parse_data(user))
		else
			respond_to_api(user)
		end
	end

	private
	def parse_data(user)
		{
			:id => user.id,
			:email => user.email,
			:authentication_token => user.authentication_token,
			:last_sign_in_at => user.last_sign_in_at
		}

	end
end