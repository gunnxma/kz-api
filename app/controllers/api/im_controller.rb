class Api::ImController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def login
		@user = User.where('account = ? and pwd = ?', params[:account], params[:pwd]).first
	end

	def contacts
		user = User.find(params[:user_id])
		@groups = []

		#教师联系人
		if user.role_id == 3
			#添加同学科教师组
			user.subjects.each do |subject|
				group = { name: "#{subject.name}-教师", contacts: [] }
				subject.users.where('unit_id = ? and role_id = ? and users.id <> ?', user.unit_id, user.role_id, user.id).each do |u|
					group[:contacts] << { ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'}
				end
				@groups << group
			end

			#添加同年级教师组
			user.klasses.select(:year).uniq.each do |klass|
				group = { name: "#{klass.year}级-教师", contacts: [] }
				User.joins(:klasses).where('klasses.year = ? and klasses.unit_id = ? and users.role_id = 3 and users.id <> ?', klass.year, user.unit_id, user.id).each do |u|
					group[:contacts] << { ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'}
				end
				@groups << group
			end

			#添加学生组
			user.klasses.each do |klass|
				group = { name: "#{klass.year}级#{klass.name}班-学生", contacts: []}
				klass.users.where('role_id = ?', 4).each do |u|
					group[:contacts] << { ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'}
				end
				@groups << group
			end

			#添加家长组
			user.klasses.each do |klass|
				group = { name: "#{klass.year}级#{klass.name}班-家长", contacts: []}
				klass.users.where('role_id = ?', 4).each do |u|
					u.parents.each do |j|
						group[:contacts] << { ease_userid: j.ease_userid, name: "#{u.name}家长-#{j.name}", logo: j.logo.thumb.url, subscription: 'both'}
					end
				end
				@groups << group
			end
		end

		#学生联系人
		if user.role_id == 4			
			user.klasses.each do |klass|
				#添加教师组
				group = { name: "#{klass.year}级#{klass.name}班-教师", contacts: []}
				klass.users.where('role_id = ?', 3).each do |u|
					group[:contacts] << { ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'}
				end				
				@groups << group

				#添加学生组
				group = { name: "#{klass.year}级#{klass.name}班-学生", contacts: []}
				klass.users.where('role_id = ? and users.id <> ?', 4, user.id).each do |u|
					group[:contacts] << { ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'}
				end
				@groups << group
			end
		end

		#家长联系人
		if user.role_id == 5
			user.children.each do |c|
				c.klasses.each do |klass|
					#添加教师组
					group = { name: "#{klass.year}级#{klass.name}班-教师", contacts: []}
					klass.users.where('role_id = ?', 3).each do |u|
						group[:contacts] << { ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'}
					end
					@groups << group
				end
			end
		end

		#教研员联系人
		if user.role_id == 2
			#本单位联系人
			group = { name: "本单位教研员", contacts: []}
			user.unit.users.all.each do |u|				
				group[:contacts] << { ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'} if u.id != user.id
			end
			@groups << group

			#下级学校教师
			#todo
		end

		@groups.each do |group|
			group[:name] = "#{group[:name]}(#{group[:contacts].count}人)"
		end
	end
end
