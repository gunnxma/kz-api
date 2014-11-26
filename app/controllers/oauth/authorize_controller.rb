class Oauth::AuthorizeController < ApplicationController
	def index
		if !OauthApplication.where('uid = ?', params[:application_id]).empty?
			authorize = OauthAccessGrant.new
			authorize.application_id = OauthApplication.where('uid = ?', params[:application_id]).first.id
			authorize.redirect_uri = params[:redirect_uri]
			authorize.resource_owner_id = 0
			authorize.token = SecureRandom.hex
			authorize.expires_in = 600
			authorize.created_at = DateTime.now
		
			if authorize.save
				if !cookies[:user_id] || cookies[:user_id].empty?
					logger.debug("authorize: #{authorize.id}")
					redirect_to index_login_path(:id => authorize.id)
				else
					redirect_to :action => :response_code, :authorize_id => authorize.id
				end
			end
		end
	end

	def response_code
		if cookies[:user_id]
			authorize = OauthAccessGrant.find(params[:authorize_id])
			authorize.resource_owner_id = cookies[:user_id]
			authorize.created_at = DateTime.now
			if authorize.save
				redirect_to authorize.redirect_uri+"?code="+authorize.token
			end			
		end
	end
end
