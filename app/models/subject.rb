class Subject < ActiveRecord::Base
	has_many :user_subjects, :dependent => :destroy
  has_many :users, :through => :user_subjects
end
