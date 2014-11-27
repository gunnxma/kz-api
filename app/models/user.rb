class User < ActiveRecord::Base
	belongs_to :role
	belongs_to :unit
	belongs_to :nation
	belongs_to :department
	belongs_to :duty
	has_many :user_subjects, :dependent => :destroy
  has_many :subjects, :through :user_subjects
  belongs_to :klass
  has_many :teacher_klasses, :dependent => :destroy
  has_many :klasses, :through => :teacher_klasses

  def self.check_login(account, pwd)
  	if !User.where( "account = ? and pwd = ? and status = 0", account, pwd).empty?
  		User.where( "account = ? and pwd = ? and status = 0", account, pwd).first
  	else
  		nil
  	end
  end
end
