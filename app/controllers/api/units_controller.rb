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

  def sub_units_by_type
    @units = []
    unit_type_id = params[:unit_type_id]
    if check_authorize
      unit = @user.unit
      if !unit.province.blank? || !unit.city.blank? || !unit.district.blank?
        if !unit.province.blank? && unit.city.blank?
          @units = Unit.where('province = ? and unit_type_id = ? and id <> ?', unit.province, unit_type_id, unit.id)
        end
        if !unit.province.blank? && !unit.city.blank? && unit.district.blank?
          @units = Unit.where('city = ? and unit_type_id = ? and id <> ?', unit.city, unit_type_id, unit.id)
        end
      else
        if !unit.region_code.blank? && unit.region_code.size == 6
          if unit.region_code[2,4] == "0000"
            @units = Unit.where("region_code LIKE ? and unit_type_id = ? and id <> ?", "#{unit.region_code[0,2]}0000%", unit_type_id, unit.id)
          else
            if unit.region_code[4,2] == "00"
              @units = Unit.where("region_code LIKE ? and unit_type_id = ? and id <> ?", "#{unit.region_code[0,4]}00%", unit_type_id, unit.id)
            end
          end
        end
      end
    end
  end

  def show
    #if check_authorize
      @unit = Unit.find(params[:id]) unless Unit.where('id = ?', params[:id]).blank?
    #end
  end

	private

	def unit_params
		params.require(:unit).permit(:name, :province, :city, :district, :address, :phone, :unit_type_id, rank_ids: [], users_attributes: [:name, :account, :pwd, :email, :mobile, :agent_id])
	end
end
