class Oauth::TokenController < ApplicationController
	skip_before_filter :verify_authenticity_token
	layout "nohead"

	def create
		application = OauthApplication.where('uid = ? and secret = ?', params[:application_id], params[:secret])
		if application
			authorize = OauthAccessGrant.where('application_id = ? and token = ?', application.first.id, params[:code])
			if authorize
				token = OauthAccessToken.new
				token.application_id = authorize.first.application_id
				token.resource_owner_id = authorize.first.resource_owner_id
				token.token = SecureRandom.hex
				token.expires_in = 3600
				token.created_at = DateTime.now
				if token.save
					render :text => { :access_token => token.token, :expires_in => token.expires_in }.to_json
				end
			end
		end
	end
end
