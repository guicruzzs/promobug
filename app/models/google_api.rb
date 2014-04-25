require 'net/http'
require 'net/https'

class GoogleApi
	def self.login
		#input
		uri = URL_GOOGLE_OAUTH + "auth"
		params = {'redirect_uri'=>  URL_BASE,
				  'response_type'=> 'code',
				  'client_id'=>     CLIENT_ID,
				  'scope'=>         "#{URL_GOOGLE_API}auth/calendar #{URL_GOOGLE_API}auth/userinfo.email #{URL_GOOGLE_API}auth/userinfo.profile",
				  'access_type'=>   'offline'
				  }
		
		body = GoogleApi.get(uri,params)
		puts "------------------------------------ BODY"
		puts body.inspect
		body
		if body.match("Moved Temporarily")
			body.match(/<A(.*)A>/)[0]
		end

	end

	def self.get_access_token(code)
		uri = URL_GOOGLE_OAUTH + "token"
		params = {'code' => code,
				  'client_id' => CLIENT_ID,
			      'client_secret' => GOOGLE_CLIENT_SECRET,
			      'redirect_uri' => URL_BASE,
			      'grant_type' => 'authorization_code'}

		body = GoogleApi.post(uri,params)
		self.respond_to_hash(body)
	end

	def self.get_user_data(code)
		access_token_response = GoogleApi.get_access_token(code)
		puts "------------------access_token_response"
		puts access_token_response.inspect
		uri = URL_GOOGLE_API + "oauth2/v1/userinfo"		
		params = {'access_token'=>  access_token_response["access_token"]}
		
		body = GoogleApi.get(uri,params)
		data_response = self.respond_to_hash(body)

		data_response["access_token_request"] = access_token_response
		data_response

	end

	def self.get_user_profile(id)
		uri = "https://www.googleapis.com/plus/v1/people/#{id}"
		params = {'key'=> GOOGLE_API_KEY}
		body = GoogleApi.post(uri,params)
		self.respond_to_hash(body)
	end

	def self.refresh_the_token(user)
		uri = URL_GOOGLE_OAUTH + "token"
		params = {'client_id'=> CLIENT_ID,
				  'client_secret'=> GOOGLE_CLIENT_SECRET,
				  'refresh_token'=>user.refresh_token,
				  'grant_type'=>'refresh_token'}
		puts params.inspect
		body = GoogleApi.post(uri,params)
		puts "----------- body"
		puts body.inspect
		self.respond_to_hash(body)
	end

	def self.get(uri,params={})
		#conexao
		uri = URI.parse(uri)
		
		http = Net::HTTP.new(uri.host, uri.port) 
		http.use_ssl = (uri.scheme == "https")
		http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  		http.ca_file = File.join(Rails.root.to_s, 'config', 'cacert.pem')
		
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
		url = URI.parse(uri)
		req = Net::HTTP::Post.new(url.request_uri)

		req.set_form_data(params)
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = (url.scheme == "https")
		http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  		http.ca_file = File.join(Rails.root.to_s, 'config', 'cacert.pem')
		
		response = http.request(req)
		response.body
	end

	def self.post_json(uri,params={})
		url = URI.parse(uri)
		
		req = Net::HTTP::Post.new(url.request_uri)
		req.body = params[:body]
    	req["Authorization"] ="Bearer #{params[:access_token]}"
    	req["Content-Type"] = "application/json"

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = (url.scheme == "https")
		http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  		http.ca_file = File.join(Rails.root.to_s, 'config', 'cacert.pem')
		
		response = http.request(req)
		response.body
	end

	def self.respond_to_hash(data)
		eval(data.gsub(/"(\s*):/, '"=>'))
	end
end