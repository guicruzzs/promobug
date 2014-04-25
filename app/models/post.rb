require 'net/http'
require 'net/https'

class Post
	
	def self.run_bell
		url = "http://crosspromobug.herokuapp.com/check_new_offers"
		params = {'release_code'=>RELEASE_CODE}

		response = GoogleApi.get(url,params)
		puts response.inspect
	end
end
