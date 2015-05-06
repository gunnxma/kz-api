#require 'httparty'

class Ease
	EASE_API_URL = "https://a1.easemob.com/kuanzheng/kuanzheng/"
	#include HTTParty

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
		#response = HTTParty.post(EASE_API_URL + "chatgroups", 
		#	headers: { "Authorization" => "Bearer #{self.token}" },
		#	body: { "groupname" => name, "desc" => desc, "public" => true, "approval" => true, "owner" => owner, "maxusers" => 1000 }.to_json
		#)
		#response["data"]["groupid"]
		response = `curl -X POST '#{EASE_API_URL}chatgroups' -H 'Authorization: Bearer #{self.token}' -d '{"groupname":"#{name}","desc":"#{desc}","public":true,"approval":true,"owner":"#{owner}","maxusers":1000}'`
		#response["data"]["groupid"]
		desc
	end

	def self.add_group_users(groupid, users)
		#response = HTTParty.post(EASE_API_URL + "chatgroups/#{groupid}/users", 
		#	headers: { "Authorization" => "Bearer #{self.token}" },
		#	body: { "usernames" => users }.to_json
		#)
		response = `curl -X POST '#{EASE_API_URL}chatgroups/#{groupid}/users' -H 'Authorization: Bearer #{self.token}' -d '{"usernames":"#{users}"}'`
	end
end