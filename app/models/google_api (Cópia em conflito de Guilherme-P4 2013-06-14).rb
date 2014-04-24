require 'net/http'
require 'net/https'

class GoogleApi
	def self.login
		#input
		uri = URI.parse(URL_GOOGLE_OAUTH + "auth")
		params = {'redirect_uri'=>  URL_BASE,
				  'response_type'=> 'code',
				  'client_id'=>     CLIENT_ID,
				  'scope'=>         "#{URL_GOOGLE_API}auth/calendar #{URL_GOOGLE_API}auth/userinfo.email #{URL_GOOGLE_API}auth/userinfo.profile"
				  }
		
		body = GoogleApi.get(uri,params)
		
		if body.match("Moved Temporarily")
			body.match(/<A(.*)A>/)[0]
		end

	end

	def self.get_token_access(code_token)
		uri = URI.parse(URL_GOOGLE_OAUTH + "token")
		puts uri.inspect
		params = {'code' => code_token,
				  'client_id' => CLIENT_ID,
			      'client_secret' => GOOGLE_CLIENT_SECRET,
			      'redirect_uri' => URL_BASE,
			      'grant_type' => 'authorization_code'}
		
		body = GoogleApi.post(uri,params)
		puts "555555555555555555555555555555555555555555"
		puts body
		# self.respond_to_hash(body)
	end
	
	def self.get_user_data(access_token)
		uri = URI.parse(URL_GOOGLE_OAUTH + "v1/userinfo")
		params = {'access_token'=>  access_token}
		
		body = GoogleApi.get(uri,params)
		puts "6666666666666666666666666666666666666666666"
		puts body
		self.respond_to_hash(body)
	end

	def self.get_user_profile(id)
		uri = URI.parse("https://www.googleapis.com/plus/v1/people/#{id}")
		params = {'key'=> "AIzaSyBFheU3FLhas3JYYUcVu2Z9fvKleKuZKvA"}
		body = GoogleApi.get(uri,params)
		self.respond_to_hash(body)
		
	end

private
	def self.get(uri,params={})
		#conexao
		http = Net::HTTP.new(uri.host, uri.port) 
		http.use_ssl = true
		request = Net::HTTP::Get.new(uri.path) 
		request.set_form_data(params)
		#get
		request = Net::HTTP::Get.new( uri.path+ '?' + request.body )

		#resposta
		response = http.request(request)
		response.body
	end

	def self.post(uri,params={})
		#conexao
                puts params.inspect
		https = Net::HTTP.new(uri.host,uri.port)
		https.use_ssl = true
		request = Net::HTTP::Post.new(uri.path)
		params.each do |key,value|
			request[key.to_s] = value
		end
		
		response = https.request(request)
		puts response.body
		# http = Net::HTTP.new(uri.host, uri.port) 
		# http.use_ssl = true
		# request = Net::HTTP::Post.new(uri.path) 
		# request.set_form_data(params)
		# #get
		# request = Net::HTTP::Post.new( uri.path+ '?' + request.body )

		# #resposta
		# response = http.request(request)
		# puts response.inspect
		# response.body
	end

	def self.respond_to_hash(data)
		eval(data.gsub(/":/, '"=>'))
	end
end
