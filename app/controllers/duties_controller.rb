class DutiesController < ApplicationController
	before_filter :check_power
	
	def index
		@duties = Duty.where('unit_id = ?', current_user.unit_id)
	end

	def new
		@duty = Duty.new
	end

	def create
		@duty = Duty.new(duty_params)
    @duty.unit_id = current_user.unit_id
        
    if @duty.save
    	flash[:notice] = "新增职务成功"
      redirect_to :action => :index
    else
    	flash[:notice] = "请正确填写职务名称"
      render "new"
    end
	end

	def edit
		@duty = Duty.find(params[:id])
	end

	def update
		@duty = Duty.find(params[:id])
    if @duty.update_attributes(duty_params)
			flash[:notice] = "修改职务成功"
      redirect_to :action => :index
    else
    	flash[:notice] = "请正确填写职务名称"
      render "edit"
    end
	end

	def destroy
		@duty = Duty.find(params[:id])
		@duty.destroy
		flash[:notice] = "删除职务成功"
    redirect_to :action => :index
	end

	private

	def duty_params
		params.require(:duty).permit(:name)
	end
end