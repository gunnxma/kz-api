class Api::UsersController < ApplicationController
	def index
		@users = User.all.select(:id,:name) if check_authorize		
	end

	def show
		@user if check_authorize
	end
end
