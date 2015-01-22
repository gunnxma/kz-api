# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

role_list = ['管理员', '教研员', '教师', '学生', '家长']
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


#测试数据

if Unit.where('name = ?', '淄博教研室').empty?
	unit = Unit.new
	unit.name = '淄博教研室'
	unit.unit_type_id = 2
	unit.pr
	unit.region_code = '370300'
	unit.province = '370000'
	unit.city = '370300'
	unit.address = 'zibo'
	unit.phone = '0533-1111111'
	unit.old_id = 11
	unit.status = 0
	unit.save
end

unit = Unit.where('name = ?', '淄博教研室').first

if User.where('account = ?', 'zbadmin').empty?		
	user = User.new
	user.unit_id = unit.id
	user.account = 'zbadmin'
	user.pwd = 'zbadmin'
	user.name = '淄博教研室管理员'
	user.role_id = 1
	user.email = 'zbadmin@zbadmin.com'
	user.mobile = '13333333333'
	user.gender = '男'
	user.birthday = '1970-1-1'
	user.nation_id = 1
	user.status = 0
	user.old_id = 129
	user.save
end

if User.where('account = ?', 'yyy').empty?
	user = User.new		
	user.unit_id = unit.id
	user.account = 'yyy'
	user.pwd = 'kz111'
	user.name = '教研员'
	user.role_id = 2
	user.email = 'jyy@zbadmin.com'
	user.mobile = '13333333334'
	user.gender = '男'
	user.birthday = '1970-1-2'
	user.nation_id = 1
	user.status = 0
	user.old_id = 20110
	user.save

	subject = UserSubject.new
	subject.user_id = user.id
	subject.rank_id = 4
	subject.subject_id = 1
	subject.save
end

if User.where('account = ?', 'kgyw').empty?
	user = User.new		
	user.unit_id = unit.id
	user.account = 'kgyw'
	user.pwd = '970900'
	user.name = '陈鲁峰'
	user.role_id = 2
	user.email = 'kgyw@zbadmin.com'
	user.mobile = '13333333335'
	user.gender = '男'
	user.birthday = '1970-1-3'
	user.nation_id = 1
	user.status = 0
	user.old_id = 130
	user.save

	subject = UserSubject.new
	subject.user_id = user.id
	subject.rank_id = 4
	subject.subject_id = 1
	subject.save
end

if Unit.where('name = ?', '宽正校园').empty?
	unit = Unit.new
	unit.name = '宽正校园'
	unit.unit_type_id = 1
	unit.region_code = '370300'
	unit.province = '370000'
	unit.city = '370300'
	unit.address = 'zibo'
	unit.phone = '0533-1111112'
	unit.old_id = 14
	unit.status = 0
	unit.save

	urank = UnitRank.new
	urank.unit_id = unit_id
	urank.rank_id = 2
	urank.save

	urank = UnitRank.new
	urank.unit_id = unit_id
	urank.rank_id = 3
	urank.save
end

unit = Unit.where('name = ?', '宽正校园').first

if User.where('account = ?', 'kuanzheng').empty?		
	user = User.new
	user.unit_id = unit.id
	user.account = 'kuanzheng'
	user.pwd = 'kzxy2012'
	user.name = '宽正校园管理员'
	user.role_id = 1
	user.email = 'kuanzheng@zbadmin.com'
	user.mobile = '13333333344'
	user.gender = '男'
	user.birthday = '1970-1-5'
	user.nation_id = 1
	user.status = 0
	user.old_id = 54
	user.save
end

if User.where('account = ?', 'teacher').empty?
	user = User.new		
	user.unit_id = unit.id
	user.account = 'teacher'
	user.pwd = '123456'
	user.name = '刘奎'
	user.role_id = 3
	user.email = 'teacher@zbadmin.com'
	user.mobile = '13333333336'
	user.gender = '男'
	user.birthday = '1970-1-8'
	user.nation_id = 1
	user.status = 0
	user.old_id = 66
	user.save

	subject = UserSubject.new
	subject.user_id = user.id
	subject.subject_id = 1
	subject.save
end

if Klass.where('unit_id = ? and name = ? and year = ?', unit.id, '1班', 2013).empty?
	klass = Klass.new
	klass.unit_id = unit.id
	klass.name = '1班'
	klass.year = 2013
	klass.status = 0
	klass.save
end

klass = Klass.where('unit_id = ? and name = ? and year = ?', unit.id, '1班', 2013).first

if User.where('account = ?', 'student').empty?
	user = User.new		
	user.unit_id = unit.id
	user.account = 'student'
	user.pwd = '123456'
	user.name = '孙杨'
	user.role_id = 4
	user.email = 'student@zbadmin.com'
	user.mobile = '13333333337'
	user.gender = '男'
	user.birthday = '1990-1-8'
	user.nation_id = 1
	user.status = 0
	user.old_id = 65
	user.save

	userklass = UserKlass.new
	userklass.user_id = user.id
	userklass.klass_id = klass.id
	userklass.save
end