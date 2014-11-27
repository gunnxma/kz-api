class Role < ActiveRecord::Base
	has_many :users
	belongs_to :unit
end
