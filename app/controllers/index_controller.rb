class IndexController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :check_login, :only => [:index, :upload_form, :upload]
  layout "nohead", :only => [ :login, :checklogin, :forget, :send_pwd, :test_imp ]

  def index
    redirect_to edit_user_path(current_user)
  end

	def login
		@authorize_id = params[:id]
		@user = User.new
	end

	def checklogin
    @user = User.new(user_params)    
    @authorize_id = params[:id]
    check_user = User.where( "account = ? and pwd = ? and status = 0", @user.account, @user.pwd).first
    if check_user
      cookies[:user_id] = check_user.id
      if !@authorize_id.empty?
        redirect_to oauth_authorize_response_code_path(:authorize_id => @authorize_id)
      else
        redirect_to :action => :index
      end
    else
      flash[:notice] = "用户名密码错误！"
      render :login
    end
  end

  def logout
    cookies.delete(:user_id)
    redirect_to :action => :login
  end

  def upload_form
  end

  def upload
    uploaded_io = params[:up_file]
    filename = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    File.open(filename, 'wb') do |file|
      file.write(uploaded_io.read)
    end
  end

  def forget

  end

  def send_pwd
    email = params[:email]
    user = User.where('account = ?', email)
    if user.any? then
      RegMailer.send_pwd(user.first).deliver
      @notice = "密码已发送到邮箱:#{email}，请注意查收！"
    else
      @notice = "没有找到对应的账号"
    end
  end

  def test_imp
    ImpUser.import(Rails.root.join('uploads', 'imp_user.xls'))
    imp_users = ImpUser.all
    @name = imp_users.first['姓名']
    logger.debug 'user count:'
    logger.debug @name
  end

  private

  def check_login
    redirect_to :controller => :index, :action => :login unless current_user
  end

  def user_params
    params.require(:user).permit(:account, :pwd)
  end
end
