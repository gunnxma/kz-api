class UnitsController < ApplicationController
	before_filter :check_power, :except => [:new, :create, :show, :active]	
  layout "nohead", :only => [ :new, :create, :show, :active ]

	def new
		@unit = Unit.new
		@unit.users.build
	end

	def create
		@unit = Unit.new(unit_params)
    @unit.status = 0

    @unit.users.each do |user|
    	if params[:pwd] != params[:pwd_confirmation]
	      flash[:notice] = "两次输入的密码不一致"
	      render "new"
	      return
	    else
	    	user.pwd = params[:pwd]
	    end
	    if user.account.include? '@'
      	user.status = -1
      else
      	user.status = 0
      end
      user.role_id = 1
    end

    if @unit.save
      redirect_to unit_path(@unit)
    else
    	flash[:notice] = "注册单位失败，请检查信息是否填写正确"
      render "new"
    end
	end

	def edit
		@unit = Unit.find(params[:id])
	end

	def update
		@unit = Unit.find(params[:id])
		if @unit.update_attributes(unit_params)
			flash[:notice] = "单位信息保存成功"
			redirect_to edit_unit_path(@unit)
		else
			flash[:notice] = "单位信息保存失败，请检查信息是否填写正确"
			render "edit"
		end
	end

	def show
		@unit = Unit.find(params[:id])
		if @unit.users.first.status == -1 then
			RegMailer.confirm(@unit.users.first.account, @unit).deliver
		end
	end

	def active
		id = params[:id]
		key = params[:key]
		user = User.find(id)
		if key == Digest::MD5.hexdigest(id.to_s+user.account)
			user.status = 0
			user.save
			flash[:notice] = "您的帐号激活成功，可以正常使用！"
		else
			flash[:notice] = "帐号激活有误，请确定链接来源是否正确！"
		end
	end

	private

	def unit_params
		params.require(:unit).permit(:name, :province, :city, :district, :address, :phone, :unit_type_id, rank_ids: [], users_attributes: [:name, :account, :pwd, :email, :mobile])
	end
end
