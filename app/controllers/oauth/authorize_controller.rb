class Oauth::AuthorizeController < ApplicationController
	layout "nohead"
	def index
		if !OauthApplication.where('uid = ?', params[:application_id]).empty?
			authorize = OauthAccessGrant.new
			application = OauthApplication.where('uid = ?', params[:application_id]).first
			authorize.application_id = application.id
			if params[:redirect_uri].blank?
				authorize.redirect_uri = application.redirect_uri
			else
				authorize.redirect_uri = params[:redirect_uri]
			end
			authorize.resource_owner_id = 0
			authorize.token = SecureRandom.hex
			authorize.expires_in = 600
			authorize.created_at = DateTime.now
		
			if authorize.save
				if !cookies[:user_id] || cookies[:user_id].empty?
					redirect_to index_login_path(:id => authorize.id)
				else					
					if !UserStatu.where('user_id = ? and status = 1', cookies[:user_id]).blank?
						cookies.delete(:user_id)
						UserStatu.where('user_id = ? and status = 1', cookies[:user_id]).update_all(status: 0)
						redirect_to index_login_path(:id => authorize.id)
					else
						redirect_to :action => :response_code, :authorize_id => authorize.id
					end
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
