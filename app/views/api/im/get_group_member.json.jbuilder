json.array! @users do |user|
  json.id user.user_id
  json.ease_id user.user.ease_userid
  if user.user.role_id == 5
  	json.name "#{user.user.name}家长"
  else
  	json.name user.user.name
  end
  json.logo user.user.logo_url
end