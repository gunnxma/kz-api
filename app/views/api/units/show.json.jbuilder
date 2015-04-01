if @unit
  json.id @unit.id
  json.name @unit.name
  json.unit_type_id @unit.unit_type_id
  json.region_code @unit.region_code
  json.province @unit.province
  json.city @unit.city
  json.district @unit.district
  json.ranks @unit.ranks.join(',')
end