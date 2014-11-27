class TeacherKlass < ActiveRecord::Base
	belongs_to :user
	belongs_to :klass
	belongs_to :subject
end
