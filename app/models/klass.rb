class Klass < ActiveRecord::Base
	has_many :user_klasses, :dependent => :destroy
	has_many :users, :through => :user_klasses
  belongs_to :unit
  belongs_to :grade
  belongs_to :rank

  validates :name,
						:presence => { :message => "班级名称不能为空" },
						:length => {:minimum => 1, :maximum => 254, :message => "名称长度不能超过254个" }
	validates :year,
						:numericality => { only_integer: true, message: "请输入正确的年份，如：2014" },
						:length => {:minimum => 4, :maximum => 4, :message => "请输入正确的年份，如：2014" }

  def teachers_count
  	self.users.where('role_id <> 4').count
  end

  def teachers
  	self.users.where('role_id <> 4')
  end

  def students_count
  	self.users.where('role_id = 4').count
  end

  def students
  	self.users.where('role_id = 4')
  end
end
