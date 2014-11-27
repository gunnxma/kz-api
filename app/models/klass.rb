class Klass < ActiveRecord::Base
	has_many :users
	has_many :teacher_klasses, :dependent => :destroy	
  has_many :teachers, :through => :teacher_klasses
  belongs_to :unit
  belongs_to :grade
end
