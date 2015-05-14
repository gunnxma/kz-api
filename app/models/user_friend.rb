class UserFriend < ActiveRecord::Base	
	belongs_to :user
	belongs_to :friend, :foreign_key => :friend_id, :primary_key => :id, :class_name => 'User'
end
