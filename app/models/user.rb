class User < ActiveRecord::Base
	class << self
		def from_onmiauth(auth_hash)
			user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
			user.name = auth_hash['info']['name']
			user.location = get_social_location(oauth_hash['provider'], auth_hash['info']['location'])
			user.image_url = auth_hash['info']['image']
			user.url = get_social_url_for(oauth_hash["provider"], oauth_hash['info']['urls'])
			user.save!
			user
		end

		private

		def get_social_location(provider, location_hash)
			case provider
			when "linkedin"
				location_hash['name']
			else
				location_hash[provider.capitalize]
			end
		end

		def get_social_url_for(provider, url_hash)
			case 
			when "linkedin"
				url_hash['public_profile']
			else
				url_hash[provider.capitalize]
			end
		end
	end
end
