class KlassesController < ApplicationController
	def index
		@q = Klass.where('unit_id = ? and status = 0', current_user.unit_id).search(params[:q])
		@klasses = @q.result.paginate(:page => params[:page]).order('year').order('name')
	end

	def new
		@klass = Klass.new
		@klass.year = DateTime.now.year
	end

	def create
		@klass = Klass.new(klass_params)
		@klass.unit_id = current_user.unit_id
		@klass.status = 0
		if @klass.save
			flash[:notice] = '添加班级成功'
			redirect_to action: :index
		else
			flash[:notice] = '添加班级失败，请正确填写以下内容'
			render 'new'
		end
	end

	def edit
		@klass = Klass.find(params[:id])
	end

	def update
		@klass = Klass.find(params[:id])
		if @klass.update_attributes(klass_params)			
			flash[:notice] = '修改班级成功'
			redirect_to action: :index
		else
			flash[:notice] = '修改班级失败，请正确填写以下内容'
			render 'edit'
		end
	end

	def destroy
		@klass = Klass.find(params[:id])
		@klass.destroy
		flash[:notice] = '删除班级成功'
		redirect_to :action => :index
	end

	private

	def klass_params
		params.require(:klass).permit(:year, :name, :grade_id)
	end
end
