class UsersController < ApplicationController
  def index    
    @q = User.where('unit_id = ? and status = 0 and role_id <> 1', current_user.unit_id).search(params[:q])
    @users = @q.result.paginate(:page => params[:page]).order(id: :desc)
  end

  def new
    @user = User.new
    @edit = false
  end

  def create
    @user = User.new(user_params)
    @user.status = 0
    @user.unit_id = current_user.unit_id
    if params[:pwd] != params[:pwd_confirmation]
      flash[:notice] = "两次输入的密码不一致"
      render "new"
      return
    else
      @user.pwd = params[:pwd]
    end
    if @user.save
      flash[:notice] = "添加帐号成功"
      redirect_to users_path
    else
      flash[:notice] = "添加帐号失败"
      render 'new'
    end     
  end

  def edit
  	@user = User.find(params[:id])
  	@user.birthday = @user.birthday.strftime('%Y-%m-%d') if @user.birthday
    @edit = true
    if !(@user.id == current_user.id || (@user.unit_id == current_user.unit_id && current_user.role_id == 1))
      redirect_to '/'
    end
  end

  def update
		@user = User.find(params[:id])
		if !params[:pwd].blank?
			if params[:pwd] != params[:pwd_confirmation]
				flash[:notice] = "两次输入的密码不一致"
				render "edit"
				return
			else
				@user.pwd = params[:pwd]
			end			
		end
    if @user.id == current_user.id || (@user.unit_id == current_user.unit_id && current_user.role_id == 1)
  		if @user.update_attributes(user_params)
  			flash[:notice] = "个人信息保存成功"
  			redirect_to edit_user_path(@user)
  		else
  			flash[:notice] = "个人信息保存失败，请检查信息是否填写正确"
  			render "edit"
  		end
    else
      redirect_to '/'
    end
  end

  def show
  	@user = User.find(params[:id])
  end

  def destroy
  	@user = User.find(params[:id])
  	@user.status = 1
  	@user.save
  	flash[:notice] = '删除用户成功'
  	redirect_to :action => :index
  end

  def set_subject
    user_id = params[:id]
    @user = User.find(user_id)
    @user_subject = UserSubject.new
    @user_subject.user_id = user_id
  end

  def save_subject
    @user_subject = UserSubject.new(user_subject_params)
    if @user_subject.save
      flash[:notice] = '学科添加成功'
      redirect_to users_set_subject_path(id: @user_subject.user_id)
    else
      @user = User.find(@user_subject.user_id)
      flash[:notice] = '学科添加失败'
      render 'set_subject'
    end
  end

  def del_subject
    user_subject = UserSubject.find(params[:id])
    user_id = user_subject.user_id
    user_subject.destroy
    flash[:notice] = '学科删除成功'
    redirect_to users_set_subject_path(id: user_id)
  end

  private

  def user_params
    if current_user.role_id == 1
      params.require(:user).permit(:role_id, :account, :name, :logo, :logo_cache, :gender, :birthday, :department_id, :duty_id, :nation_id, :email, :mobile)
    else
      params.require(:user).permit(:name, :logo, :logo_cache, :gender, :birthday, :nation_id, :email, :mobile)
    end
  end

  def user_subject_params
    params.require(:user_subject).permit(:user_id, :rank_id, :subject_id)
  end
end
