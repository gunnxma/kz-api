#json.array! @users, :id, :account, :name, :email, :mobile, :department_id
json.array! @users do |user|
  json.id user.id
  json.account user.account
  json.name user.name
  json.email user.email
  json.mobile user.mobile
  json.department_id user.department_id
  json.department_name user.department.name if user.department
end