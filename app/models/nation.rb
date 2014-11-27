class Nation < ActiveRecord::Base
	has_many :users
end
