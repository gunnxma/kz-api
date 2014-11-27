class Unit < ActiveRecord::Base
	has_many :users
	has_many :departments
	has_many :duties
	belongs_to :school_rank
	has_many :roles
	belongs_to :unit_type
	has_many :klasses
end
