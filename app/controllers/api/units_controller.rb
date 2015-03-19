class Api::UnitsController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def create
		@unit = Unit.new(unit_params)
    @unit.status = 0

    @unit.users.each do |user|      
      user.status = 0
      user.role_id = 1
    end

    if @unit.save
      render plain: @unit.users.first.id
    else
    	render plain: '0'
    end
	end

	private

	def unit_params
		params.require(:unit).permit(:name, :province, :city, :district, :address, :phone, :unit_type_id, rank_ids: [], users_attributes: [:name, :account, :pwd, :email, :mobile, :agent_id])
	end
end
