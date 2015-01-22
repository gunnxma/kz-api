class DepartmentsController < ApplicationController
	before_filter :check_power
	
	def index
		@departments = Department.where('unit_id = ?', current_user.unit_id)
	end

	def new
		@department = Department.new
	end

	def create
		@department = Department.new(department_params)
    @department.unit_id = current_user.unit_id
        
    if @department.save
    	flash[:notice] = "新增部门成功"
      redirect_to :action => :index
    else
    	flash[:notice] = "请正确填写部门名称"
      render "new"
    end
	end

	def edit
		@department = Department.find(params[:id])
	end

	def update
		@department = Department.find(params[:id])
    if @department.update_attributes(department_params)
			flash[:notice] = "修改部门成功"
      redirect_to :action => :index
    else
    	flash[:notice] = "请正确填写部门名称"
      render "edit"
    end
	end

	def destroy
		@department = Department.find(params[:id])
		@department.destroy
		flash[:notice] = "删除部门成功"
    redirect_to :action => :index
	end

	private

	def department_params
		params.require(:department).permit(:name)
	end
end
