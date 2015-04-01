if @user
	json.result 'success'
	json.id @user.id
	json.account @user.account
	json.name @user.name
	json.role_id @user.role_id
	json.role_name @user.role ? @user.role.name : nil
	json.subjects @user.subjects, :id, :name
	json.email @user.email
	json.mobile @user.mobile
	json.unit_id @user.unit_id
	if @user.unit
		json.unit_name @user.unit ? @user.unit.name : nil
		json.unit_type @user.unit ? @user.unit.unit_type_id : nil
		json.unit_type_name @user.unit ? @user.unit.unit_type.name : nil
		json.unit_ranks @user.unit.ranks, :id, :name if @user.unit
		json.unit_region_code @user.unit ? @user.unit.region_code : nil
		json.unit_province @user.unit.province ? @user.unit.province : nil
		json.unit_city @user.unit.city ? @user.unit.city : nil
		json.unit_district @user.unit.district ? @user.unit.district : nil
		json.unit_region_name @user.unit ? "#{ChinaCity.get(@user.unit.province)}#{ChinaCity.get(@user.unit.city)}#{ChinaCity.get(@user.unit.district)}" : nil
	end
	json.gender @user.gender
	json.birthday @user.birthday
	json.nation_id @user.nation_id
	json.nation_name @user.nation ? @user.nation.name : nil
	json.department_id @user.department_id
	json.duty_id @user.duty_id
	json.duty_name @user.duty ? @user.duty.name : nil
	json.logo @user.logo
	json.old_id @user.old_id
	json.agent_id @user.agent_id
else
	json.result 'not found'
end