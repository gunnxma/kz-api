if @user
	json.result 'success'
	json.id @user.id
	if @user.role_id == 5
		json.name "#{@user.name}家长"
	else
		json.name @user.name
	end
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
	json.logo @user.logo_url
	json.old_id @user.old_id
	json.ease_account @user.ease_userid
	json.ease_pwd Digest::MD5.hexdigest("#{@user.ease_userid}kz2015")
else
	json.result 'not found'
end