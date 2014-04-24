class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :status, :code_token, :access_token, :access_token_time

  has_one :agenda
  
  STATUS_ATIVO = true
  STATUS_INATIVO = false
  
	def self.generate_pass(email)
		Cypher.encrypt(email)
	end

	def self.get_user(code)
		user_data_response = GoogleApi.get_user_data(code)

		user = User.where(:email=>user_data_response["email"]).first
		puts "--------- user"
		puts user.inspect
		puts "--------- user_data_response"
		puts  user_data_response["access_token_request"].inspect
		if user.nil?
			user = self.create!(:email=> user_data_response["email"],
								:password=> User.generate_pass(user_data_response["email"]),
								:name=> user_data_response["name"],
								:status=> User::STATUS_ATIVO,
								:code_token=> code,
								:access_token=> user_data_response["access_token_request"]["access_token"],
								:refresh_token=>user_data_response["access_token_request"]["refresh_token"],
								:access_token_time => DateTime.now,
								:expires_in=>user_data_response["access_token_request"]["expires_in"])
		else
			user.code_token = code
			user.access_token = user_data_response["access_token_request"]["access_token"]
			user.refresh_token = user_data_response["access_token_request"]["refresh_token"] if user_data_response["access_token_request"]["refresh_token"]
			user.expires_in = user_data_response["access_token_request"]["expires_in"]
			user.save
		end

		return user			
	end

	def refresh_access_token
		data_response = GoogleApi.refresh_the_token(self)
		puts "---------- data_response"
		puts data_response.inspect
		
		if data_response["access_token"]
			self.access_token = data_response["access_token"]
			self.expires_in = data_response["expires_in"]
			self.save
		end	
	end

	def self.login(email)
		user = User.where(:email=>email).first
		return false if user.nil?
	end

	def check_token_expiration
		if (Time.now > (self.updated_at+(self.expires_in-60).seconds))
			self.refresh_access_token
		end
	end
end
