require 'httparty'

class Ease
	EASE_API_URL = "https://a1.easemob.com/kuanzheng/kuanzheng/"
	include HTTParty

	def self.token
		token = EaseToken.first

		if token.blank? || token.expires_in.blank? || (token.updated_at + token.expires_in.seconds) < DateTime.now
			token = EaseToken.new if token.blank?
			token.token, token.expires_in = self.get_token
			token.save
		end
		token.token
	end

	def self.get_token
		response = HTTParty.post(EASE_API_URL + "token", 
			body: { "grant_type" => "client_credentials", "client_id" => "YXA6k-Gl0J1UEeSqlgMYyOaHcQ", "client_secret" => "YXA654RsXVdv3n-sJdkSnDWnXr1kOKk" }.to_json
		)
		[ response["access_token"], response["expires_in"] ]
	end

	def self.add_group(name, desc, owner)
		response = HTTParty.post(EASE_API_URL + "chatgroups", 
			headers: { "Authorization" => "Bearer #{self.token}" },
			body: { "groupname" => name, "desc" => desc.to_s, "public" => true, "approval" => true, "owner" => owner, "maxusers" => 1000 }.to_json
		)
		response["data"]["groupid"]
	end

	def self.add_group_users(groupid, users)
		response = HTTParty.post(EASE_API_URL + "chatgroups/#{groupid}/users", 
			headers: { "Authorization" => "Bearer #{self.token}" },
			body: { "usernames" => users }.to_json
		)
		#puts "==============================================="
		#puts "ease_groupid:#{groupid},users count:#{users.count}"
		#puts "body:#{{ "usernames" => users }.to_json}"
		#puts "response code:#{response.code}"
		#puts "response body:#{response.body}"
		#puts "==============================================="
	end
end