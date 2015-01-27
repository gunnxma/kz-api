class Api::ImController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def login
		@user = User.where('account = ? and pwd = ?', params[:account], params[:pwd]).first
	end
end
