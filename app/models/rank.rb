class Rank < ActiveRecord::Base
	has_many :unit_ranks
	has_many :units, :through => :unit_ranks
end
