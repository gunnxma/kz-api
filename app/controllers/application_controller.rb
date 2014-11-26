class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def check_authorize
  	token = params[:token]
  	if OauthAccessToken.where('token = ?', token).empty?
  		false
  	else
  		user_id = OauthAccessToken.where('token = ?', token).first.resource_owner_id
  		@user = User.find(user_id)
  		if @user
  			true
  		else
  			false
  		end
  	end
  end
end
