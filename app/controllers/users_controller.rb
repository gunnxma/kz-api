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

  def imp_teacher

  end

  def imp_teacher_save
    uploaded_io = params[:imp_file]
    filename = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    File.open(filename, 'wb') do |file|
      file.write(uploaded_io.read)
    end

    ImpTeacher.import(filename)
    ImpTeacher.all.each do |teacher|
      user = User.new   
      user.unit_id = current_user.unit_id
      user.account = teacher['帐号']
      user.pwd = teacher['密码']
      user.name = teacher['姓名']
      user.role_id = 3
      user.status = 0
      if user.save
        u_subject = Subject.where('name = ?', teacher['学科']).first
        if u_subject
          subject = UserSubject.new
          subject.user_id = user.id
          subject.subject_id = u_subject.id
          subject.save
        end
      end
    end

    redirect_to :users
  end

  def imp_student

  end

  def imp_student_save
    uploaded_io = params[:imp_file]
    filename = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    File.open(filename, 'wb') do |file|
      file.write(uploaded_io.read)
    end

    ImpStudent.import(filename)
    ImpStudent.all.each do |student|
      user = User.new   
      user.unit_id = current_user.unit_id
      user.account = student['帐号']
      user.pwd = student['密码']
      user.name = student['姓名']
      user.role_id = 4
      user.status = 0

      if user.save
        parent = User.new
        parent.unit_id = current_user.unit_id
        parent.account = student['家长帐号']
        parent.pwd = student['家长密码']
        parent.name = student['家长姓名']
        parent.role_id = 5
        parent.status = 0
        parent.save

        parent_child = ParentChild.new
        parent_child.parent_id = parent.id
        parent_child.child_id = user.id
        parent_child.save

        u_class = Klass.where('unit_id = ? and name = ? and year = ?', user.unit_id, student['班级'].split('.').first, student['入学年份']).first
        if u_class
          userklass = UserKlass.new
          userklass.user_id = user.id
          userklass.klass_id = u_class.id
          userklass.save
        end   
      else
        logger.debug user.errors.messages
      end   
    end

    redirect_to :users
  end

  private

  def user_params
    if current_user.role_id == 1
      params.require(:user).permit(:role_id, :account, :name, :logo, :logo_cache, :gender, :birthday, :department_id, :duty_id, :nation_id, :email, :mobile)
    else
      if current_user.account_check
        params.require(:user).permit(:name, :logo, :logo_cache, :gender, :birthday, :nation_id, :email, :mobile)
      else
        params.require(:user).permit(:account, :name, :logo, :logo_cache, :gender, :birthday, :nation_id, :email, :mobile)
      end
    end
  end

  def user_subject_params
    params.require(:user_subject).permit(:user_id, :rank_id, :subject_id)
  end
end
