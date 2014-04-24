class Cypher

	def self.encrypt(string)
		salt = CRYPT_KEY
		Digest::SHA1.hexdigest("--#{salt}--#{string}--")
	end
	
end