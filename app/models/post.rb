require 'net/http'
require 'net/https'

class Post
	
	def self.con
		access_token="ya29.AHES6ZRvSC1A-Ho4Qn5JeG3Aazq5DwnKs3u7nZtlGxLIeDm2"
	end

	def self.con2
		#input
		uri = URI.parse("https://accounts.google.com/o/oauth2/auth")
		params = {'response_type'=>'token',
				  'scope'=>'https://www.googleapis.com/auth/calendar',
				  'client_id'=>'342833357798-tirkltmccr2dhdbea1curhpcain7aurj.apps.googleusercontent.com',
				  'redirect_uri'=>'http://guicruz.no-ip.org/'}
		
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
end
