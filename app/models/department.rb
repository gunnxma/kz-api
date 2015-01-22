class Department < ActiveRecord::Base
	belongs_to :unit
	has_many :users

	validates_presence_of :name
	validates_presence_of :unit_id
end
