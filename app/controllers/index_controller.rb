class IndexController < ApplicationController
	def login
		@authorize_id = params[:id]
		@user = User.new
	end

	def checklogin
    @user = User.new(user_params)    
    @authorize_id = params[:id]
    check_user = User.where( "account = ? and pwd = ?", @user.account, @user.pwd).first
    if check_user
      cookies[:user_id] = check_user.id
      redirect_to oauth_authorize_response_code_path(:authorize_id => @authorize_id)
    else
      flash[:notice] = "用户名密码错误！"
      render :login
    end
  end

  private

  def user_params
    params.require(:user).permit(:account, :pwd)
  end
end
