if @user
	json.result 'success'
	json.name @user.name
	json.role_name @user.role ? @user.role.name : nil
	json.email @user.email
	json.mobile @user.mobile
	if @user.unit
		json.unit_name @user.unit ? @user.unit.name : nil
		json.unit_type_name @user.unit ? @user.unit.unit_type.name : nil
	end
	json.gender @user.gender
	json.birthday @user.birthday
	json.nation_name @user.nation ? @user.nation.name : nil
	json.duty_name @user.duty ? @user.duty.name : nil
	json.logo @user.logo
	json.old_id @user.old_id
	json.ease_account @user.old_id ? (@user.unit.unit_type_id == 1 ? "sd_edu_#{@user.old_id}" : "sd_jys_#{@user.old_id}") : "sd_new_#{@user.id}"
	json.ease_pwd Digest::MD5.hexdigest("#{@user.old_id ? (@user.unit.unit_type_id == 1 ? "sd_edu_#{@user.old_id}" : "sd_jys_#{@user.old_id}") : "sd_new_#{@user.id}"}kz2015")
else
	json.result 'not found'
end