# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

role_list = ['管理员', '教研员', '教师', '学生', '家长', '专家']
role_list.each do |item|
	Role.create(:name => item) if Role.where('name = ? ', item).empty?
end

nation_list = ['汉族', '蒙古族', '回族', '藏族', '维吾尔族', '苗族', '彝族', '壮族', '布依族', '朝鲜族', '满族', '侗族', '瑶族', '白族', '家族', '哈尼族', '哈萨克族', '傣族', '黎族', '傈僳族', '佤族', '畲族', '高山族', '拉祜族', '水族', '东乡族', '纳西族', '景颇族', '柯尔克族', '土族', '达翰尔族', '仫佬族', '羌族', '布朗族', '撒拉族', '毛南族', '仡佬族', '锡伯族', '阿昌族', '普米族', '塔克族', '怒族', '乌孜别克族', '俄罗斯族', '鄂温克族', '德昂族', '保安族', '裕固族', '京族', '塔塔尔族', '独龙族', '鄂伦春族', '赫哲族', '门巴族', '珞巴族', '基诺族']
nation_list.each do |item|
	Nation.create(:name => item) if Nation.where('name = ?', item).empty?
end

subject_list = ['语文', '数学', '英语', '物理', '化学', '生物', '地理', '历史', '科学', '体育', '音乐', '美术', '信息技术', '通用技术', '综合实践', '品生与品社', '思想品德', '学前教育']
subject_list.each do |item|
	Subject.create(:name => item, :unit_id => 0) if Subject.where('name = ? and unit_id = 0', item).empty?
end

rank_list = ['学前', '小学', '初中', '高中']
rank_list.each do |item|
	Rank.create(:name => item) if Rank.where('name = ?', item).empty?
end

unit_type_list = ['学校', '教委']
unit_type_list.each do |item|
	UnitType.create(:name => item) if UnitType.where('name = ?', item).empty?
end

grade_list = [ '学前', '小学一年级', '小学二年级', '小学三年级', '小学四年级', '小学五年级', '小学六年级', '初中一年级', '初中二年级', '初中三年级', '初中四年级', '高中一年级', '高中二年级', '高中三年级' ]
grade_list.each do |item|
	Grade.create(:name => item) if Grade.where('name = ?', item).empty?
end