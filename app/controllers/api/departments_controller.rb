class Api::DepartmentsController < ApplicationController
	def index
		@departments = Department.where('unit_id = ?', @user.unit_id) if check_authorize
	end
end
