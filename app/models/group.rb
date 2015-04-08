class Group < ActiveRecord::Base
	has_many :user_groups

	def self.add(name, mark, contacts)
		return if contacts.blank?
		group = Group.where('mark = ?', mark).first
		if group.blank? || group.ease_groupid.blank?
			if group.blank?
				group = Group.new
				group.name, group.mark = name, mark
			end
			group.ease_groupid = Ease.add_group(group.name, group.id, contacts.first[:ease_userid])
			group.save
		end

		users = []
		contacts.each do |user|
			users << user[:ease_userid]
		end
		Ease.add_group_users(group.ease_groupid, users)
	end
end
