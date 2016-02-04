class User < ActiveRecord::Base
	class << self
		def from_onmiauth(auth_hash)
			user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
			user.name = auth_hash['info']['name']
			user.location = auth_hash['info']['location']
			user.image_url = auth_hash['info']['image']
			if auth_hash['provider'] == "Twitter"
				user.url = auth_hash['info']['urls']['Twitter']
			elsif auth_hash['provider'] == "Facebook"
				user.url = auth_hash['info']['urls'][user.provider.capitalize]
			elsif auth_hash['provider'] == "Google"
				user.url = auth_hash['info']['urls'][user.provider.capitalize]
			end
			user.save!
			user
		end
	end
end
