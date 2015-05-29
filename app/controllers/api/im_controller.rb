class Api::ImController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def login
		@user = User.where('account = ? and pwd = ?', params[:account], params[:pwd]).first
	end

	def contacts
		user = User.find(params[:user_id])
		@groups = []

		group = { name: "我的好友", contacts: [] }
		user.friends.each do |u|
			if u.role_id == 5
				u_name = "#{u.name}家长"
			else
				u_name = u.name
			end
			group[:contacts] << { userid: u.id, ease_userid: u.ease_userid, name: u_name, logo: u.logo.thumb.url, subscription: 'both'}
		end
		@groups << group

		#教师联系人
		if user.role_id == 3
			#添加同学科教师组
			user.subjects.each do |subject|
				group = { name: "#{subject.name}-教师", contacts: [] }
				subject.users.where('unit_id = ? and role_id = ? and users.id <> ?', user.unit_id, user.role_id, user.id).each do |u|
					group[:contacts] << { userid: u.id, ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'}
				end
				@groups << group

				g_group = group[:contacts].clone
				g_group << { userid: user.id, ease_userid: user.ease_userid, name: user.name, subscription: 'both' }
				Group.add(group[:name], "subject_teacher_#{user.unit_id}_#{subject.id}", g_group)
			end

			#添加同年级教师组
			user.klasses.select(:year).uniq.each do |klass|
				group = { name: "#{klass.year}级-教师", contacts: [] }
				#User.joins(:klasses).where('klasses.year = ? and klasses.unit_id = ? and users.role_id = 3 and users.id <> ?', klass.year, user.unit_id, user.id).each do |u|
				#	group[:contacts] << { ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'}
				#end
				Klass.where('year = ? and unit_id = ?', klass.year, user.unit_id).each do |k|
					k.users.where('role_id = ? and users.id <> ?', 3, user.id).each do |u|
						tt = { userid: u.id, ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'}
						group[:contacts] << tt unless group[:contacts].include?(tt)
					end
				end
				@groups << group

				g_group = group[:contacts].clone
				g_group << { userid: user.id, ease_userid: user.ease_userid, name: user.name, subscription: 'both' }
				Group.add(group[:name], "grade_teacher_#{user.unit_id}_#{klass.year}", g_group)
			end

			#添加学生组
			user.klasses.each do |klass|
				group = { name: "#{klass.year}级#{klass.name}班-学生", contacts: []}
				klass.users.where('role_id = ?', 4).each do |u|
					group[:contacts] << { userid: u.id, ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'}
				end
				@groups << group

				g_group = group[:contacts].clone
				klass.users.where('role_id = ?', 3).each do |u|
					g_group << { userid: u.id, ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'}
				end
				#Group.add(group[:name], "student_#{user.unit_id}_#{klass.id}", g_group)
			end

			#添加家长组
			user.klasses.each do |klass|
				group = { name: "#{klass.year}级#{klass.name}班-家长", contacts: []}
				klass.users.where('role_id = ?', 4).each do |u|
					u.parents.each do |j|
						group[:contacts] << { userid: j.id, ease_userid: j.ease_userid, name: "#{u.name}家长-#{j.name}", logo: j.logo.thumb.url, subscription: 'both'}
					end
				end
				@groups << group

				g_group = group[:contacts].clone
				klass.users.where('role_id = ?', 3).each do |u|
					g_group << { userid: u.id, ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'}
				end
				#Group.add(group[:name], "home_#{user.unit_id}_#{klass.id}", g_group)
			end
		end

		#学生联系人
		if user.role_id == 4			
			user.klasses.each do |klass|
				#添加教师组
				group = { name: "#{klass.year}级#{klass.name}班-教师", contacts: []}
				klass.users.where('role_id = ?', 3).each do |u|
					group[:contacts] << { userid: u.id, ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'}
				end				
				@groups << group

				g_group = group[:contacts].clone
				klass.users.where('role_id = ?', 4).each do |u|
					g_group << { userid: u.id, ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'}
				end
				#Group.add(group[:name], "student_#{user.unit_id}_#{klass.id}", g_group)

				#添加学生组
				group = { name: "#{klass.year}级#{klass.name}班-学生", contacts: []}
				klass.users.where('role_id = ? and users.id <> ?', 4, user.id).each do |u|
					group[:contacts] << { userid: u.id, ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'}
				end
				@groups << group

				g_group = group[:contacts].clone
				#klass.users.where('role_id = ?', 3).each do |u|
				#	g_group << { userid: u.id, ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'}
				#end
				g_group << { userid: user.id, ease_userid: user.ease_userid }
				Group.add(group[:name], "student_#{user.unit_id}_#{klass.id}", g_group)
			end
		end

		#家长联系人
		if user.role_id == 5
			user.children.each do |c|
				c.klasses.each do |klass|
					#添加教师组
					group = { name: "#{klass.year}级#{klass.name}班-教师", contacts: []}
					klass.users.where('role_id = ?', 3).each do |u|
						group[:contacts] << { userid: u.id, ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'}
					end
					@groups << group

					#g_group = group[:contacts].clone
					g_group = []
					klass.users.where('role_id = ?', 4).each do |u|
						u.parents.each do |j|
							g_group << { userid: j.id, ease_userid: j.ease_userid, name: "#{u.name}家长-#{j.name}", logo: j.logo.thumb.url, subscription: 'both'}
						end
					end
					Group.add("#{klass.year}级#{klass.name}班-家长", "home_#{user.unit_id}_#{klass.id}", g_group)
				end
			end
		end

		#教研员联系人
		if user.role_id == 2
			#本单位联系人
			group = { name: "本单位教研员", contacts: []}
			user.unit.users.all.each do |u|				
				group[:contacts] << { userid: u.id, ease_userid: u.ease_userid, name: u.name, logo: u.logo.thumb.url, subscription: 'both'} if u.id != user.id
			end
			@groups << group

			g_group = group[:contacts].clone
			g_group << { userid: user.id, ease_userid: user.ease_userid }
			Group.add(group[:name], "jyy_#{user.unit_id}", g_group)

			#下级学校教师
			#todo
		end

		@groups.each do |group|
			group[:name] = "#{group[:name]}(#{group[:contacts].count}人)"
		end
	end

	def get_group_member
		ease_groupid = params[:ease_groupid]
		group = Group.where('ease_groupid = ?', ease_groupid).first
		if group
			@users = Group.where('ease_groupid = ?', ease_groupid).first.user_groups
		else
			@users = []
		end
	end

	def get_user_info
		ease_id = params[:ease_id]
		user_id = params[:user_id]
		account = params[:account]

		if !user_id.blank?
			@user = User.where('id = ?', user_id).first
			return
		end

		if !account.blank?
			@user = User.where('account = ?', account).first
			return
		end

		if !ease_id.blank?
			@user = get_user_by_ease_id(ease_id)
		end
	end

	def get_users_by_ease_ids
		ease_ids = params[:ease_ids]
		@users = []

		ease_ids.split(',').each do |ease_id|
			if !ease_id.blank?
				u = get_user_by_ease_id(ease_id)
				@users << u unless @users.include? u
			end
		end
	end

	#def add_group
	#	name = params[:name]
	#	user_id = params[:user_id]
	#	ease_id = params[:ease_id]
#
	#	if !user_id.blank?
	#		user = User.where('id = ?', user_id).first
	#	end
	#	if !ease_id.blank?
	#		user = get_user_by_ease_id(ease_id)
	#	end
	#	contacts = []
	#	contacts << { userid: user.id, ease_userid: user.ease_userid, name: user.name, logo: user.logo.thumb.url, subscription: 'both'} unless #user.blank?
	#	Group.add(name, "group_#{user.id}_#{name}", contacts)
	#	render plain: 'ok'
	#end

	def add_group
		ease_groupid = params[:ease_groupid]
		name = params[:name]
		ease_ids = params[:ease_ids]

		if Group.where('ease_groupid = ?', ease_groupid).blank?
			Group.create(:ease_groupid => ease_groupid, :name => name, :mark => "usergroup_#{ease_groupid}")
		end
		group = Group.where('ease_groupid = ?', ease_groupid).first
		ease_ids.split(',').each do |ease_id|
			user = get_user_by_ease_id(ease_id)
			if user
				UserGroup.create(user_id: user.id, group_id: group.id) if UserGroup.where('user_id = ? and group_id = ?', user.id, group.id).blank?
			end
		end
		render plain: 'ok'
	end

	def group_remove_member
		ease_groupid = params[:ease_groupid]
		ease_ids = params[:ease_ids]
		
		group = Group.where('ease_groupid = ?', ease_groupid).first
		if group
			ease_ids.split(',').each do |ease_id|
				user = get_user_by_ease_id(ease_id)
				if user
					UserGroup.where('user_id = ? and group_id = ?', user.id, group.id).delete_all
				end
			end
		end
		render plain: 'ok'
	end

	def remove_group
		ease_groupid = params[:ease_groupid]
		
		group = Group.where('ease_groupid = ?', ease_groupid).first
		if group
			UserGroup.where('group_id = ?', group.id).delete_all
			group.destroy
		end
		render plain: 'ok'
	end

	def add_friend
		ease_id = params[:ease_id]
		friend_ease_id = params[:friend_ease_id]

		user_id = get_user_by_ease_id(ease_id).id
		friend_id = get_user_by_ease_id(friend_ease_id).id
		if UserFriend.where('user_id = ? and friend_id = ?', user_id, friend_id).blank?
			UserFriend.create(:user_id => user_id, :friend_id => friend_id)
		end
		if UserFriend.where('user_id = ? and friend_id = ?', friend_id, user_id).blank?
			UserFriend.create(:user_id => friend_id, :friend_id => user_id)
		end
		render plain: 'ok'
	end

	def remove_friend
		ease_id = params[:ease_id]
		friend_ease_id = params[:friend_ease_id]

		user_id = get_user_by_ease_id(ease_id).id
		friend_id = get_user_by_ease_id(friend_ease_id).id
		unless UserFriend.where('user_id = ? and friend_id = ?', user_id, friend_id).blank?
			UserFriend.where('user_id = ? and friend_id = ?', user_id, friend_id).delete_all
		end
		unless UserFriend.where('user_id = ? and friend_id = ?', friend_id, user_id).blank?
			UserFriend.where('user_id = ? and friend_id = ?', friend_id, user_id).delete_all
		end
		render plain: 'ok'
	end

	def photo_test
		render 'photo_test', layout: nil
	end

	def photo
		user_id = params[:user_id]
		user = User.find(user_id)
		user.logo = params[:logo]
		if user.save
			render plain: user.logo_url
		else
			render plain: 'err'
		end
	end

	private

	def get_user_by_ease_id(ease_id)
		if ease_id[0,6] == "sd_new"
			u = User.where('id = ?', ease_id[7,ease_id.length-7]).first
			return u
		end
		if ease_id[0,6] == "sd_edu"
			User.where('old_id = ?', ease_id[7,ease_id.length-7]).each do |u|
				if u.unit.unit_type_id == 1
					return u
				end
			end
		end
		if ease_id[0,6] == "sd_jys"
			User.where('old_id = ?', ease_id[7,ease_id.length-7]).each do |u|
				if u.unit.unit_type_id == 2
					return u
				end
			end
		end
	end
end
