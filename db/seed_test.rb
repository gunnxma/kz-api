#测试数据

if Unit.where('name = ?', '淄博教研室').empty?
	unit = Unit.new
	unit.name = '淄博教研室'
	unit.unit_type_id = 2
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