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
end
