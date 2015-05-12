json.array! @users do |user|
  json.id user.user_id
  json.ease_id user.user.ease_userid
  json.name user.user.name
  json.logo user.user.logo_url
end