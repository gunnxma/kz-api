class Unit < ActiveRecord::Base
	has_many :oauth_applications
	has_many :users
	has_many :departments
	has_many :duties
	has_many :unit_ranks, :dependent => :destroy
	has_many :ranks, :through => :unit_ranks
	has_many :roles
	belongs_to :unit_type
	has_many :klasses

	accepts_nested_attributes_for :users

	validates :name,
						:presence => { :message => "名称不能为空" },
						:length => {:minimum => 1, :maximum => 254, :message => "名称长度不能超过254个" }
	validates_presence_of :unit_type_id
	validates :address,
						:length => {:maximum => 254, :message => "地址长度不能超过254个字" }
	validates_presence_of :status

	def region_code_all		
		code = ''
		code = self.province unless self.province.blank?
		code = self.city unless self.city.blank?
		code = self.district unless self.district.blank?
	end
end
