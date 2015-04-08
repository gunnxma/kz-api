class Api::UsersController < ApplicationController
	def index
		if check_authorize
			logger.debug(@user.unit_id)
			@users = User.where('unit_id = ?', @user.unit_id)
			@users = @users.where('role_id = ?', params[:role_id]) unless params[:role_id].blank?
			@users = @users.where(' id in (select user_id from user_subjects where subject_id = ?)', params[:subject_id]) unless params[:subject_id].blank?
			@users = @users.where(' department_id = ? ', params[:department_id]) unless params[:department_id].blank?
		end
	end

	def show
		@user if check_authorize
	end

	def logout
		if check_authorize
			if UserStatu.where('user_id = ?', @user.id).blank?
				UserStatu.create(user_id: @user.id, status: 1)
			else
				UserStatu.where('user_id = ?', @user.id).update_all(status: 1)
			end
			render :plain => 'ok'
			return
		end
		render :plain => 'error'
	end

	def get_zj
		@zjs = []
		if check_authorize
			if @user.unit.unit_type_id == 2
				@zjs = User.where('unit_id = ? and role_id = ?', @user.unit.id, 6)
			end
		end
		@zjs
	end

	def get_teacher
		if check_authorize
			school_name = params[:school_name]
			name = params[:name]
			subject_id = params[:subject_id]
			school_id = params[:school_id]

			@users = User.where('status = 0 and role_id = 3')
			@users = @users.where(unit_id: Unit.where('name like ?', "%#{school_name}%").pluck(:id)) unless school_name.blank?
			@users = @users.where('name like ?', "%#{name}%") unless name.blank?
			@users = @users.where(id: UserSubject.where(subject_id: subject_id).pluck(:user_id)) unless subject_id.blank?
			@users = @users.where(unit_id: school_id) unless school_id.blank?
		end
	end

	def get_user
		#if check_authorize
			@user = User.find(params[:user_id]) unless User.where('id = ?', params[:user_id]).blank?
		#end
	end
end
