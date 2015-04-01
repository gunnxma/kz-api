json.array! @zjs do |zj|
  json.id zj.id
  json.zj_account zj.account
  json.zj_name zj.name
  json.email zj.email
  json.mobile zj.mobile
  json.logo zj.logo_url
  json.unit_name zj.unit.name if zj.unit
end