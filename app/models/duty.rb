class Duty < ActiveRecord::Base
	belongs_to :unit
	has_many :users

	validates_presence_of :name	
end
