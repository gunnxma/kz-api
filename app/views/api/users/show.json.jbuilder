if @user
	json.result 'success'
	json.id @user.id
	json.name @user.name
	json.role_id @user.role_id
	json.role_name @user.role ? @user.role.name : nil
	json.email @user.email
	json.mobile @user.mobile
	json.unit_id @user.unit_id
	json.unit_name @user.unit ? @user.unit.name : nil
	json.unit_type @user.unit ? @user.unit.unit_type_id : nil
	json.gender @user.gender
	json.birthday @user.birthday
	json.nation_id @user.nation_id
	json.nation_name @user.nation ? @user.nation.name : nil
	json.department_id @user.department_id
	json.duty_id @user.duty_id
	json.duty_name @user.duty ? @user.duty.name : nil
	json.logo @user.logo
	json.old_id @user.old_id
else
	json.result 'not found'
end