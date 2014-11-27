class Department < ActiveRecord::Base
	belongs_to :unit
	has_many :users
end
