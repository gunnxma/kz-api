class UserSubject < ActiveRecord::Base
	belongs_to :user
	belongs_to :subject
	belongs_to :rank

	validates :subject_id,
            :presence => { :message => "学科不能为空" } 
  validates :user_id,
            :presence => { :message => "用户不能为空" } 
end
