class ParentChild < ActiveRecord::Base
	belongs_to :parent, :foreign_key => :parent_id, :primary_key => :id, :class_name => 'User'
	belongs_to :child, :foreign_key => :child_id, :primary_key => :id, :class_name => 'User'
end
