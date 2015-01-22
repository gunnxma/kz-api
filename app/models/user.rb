class User < ActiveRecord::Base
  mount_uploader :logo, LogoUploader
	belongs_to :role
	belongs_to :unit
	belongs_to :nation
	belongs_to :department
	belongs_to :duty
	has_many :user_subjects, :dependent => :destroy
  has_many :subjects, :through => :user_subjects
  has_many :user_klasses, :dependent => :destroy
  has_many :klasses, :through => :user_klasses

  validates :role_id,
            :presence => { :message => "身份不能为空" }            

  validates :account,
            :presence => { :message => "帐号不能为空" },
            :uniqueness => { :message => "帐号已经存在" },
            :length => {:minimum => 1, :maximum => 254, :message => "帐号长度不能超过254个" }

  validate :account_validation

  validates :pwd,
            :presence => { :message => "密码不能为空" },
            :length => {:minimum => 6, :maximum => 254, :message => "密码长度不能少于6位" }

  validates :name,
            :length => { :maximum => 254, :message => "姓名长度不能超过254个" }

  def self.check_login(account, pwd)
  	if !User.where( "account = ? and pwd = ? and status = 0", account, pwd).empty?
  		User.where( "account = ? and pwd = ? and status = 0", account, pwd).first
  	else
  		nil
  	end
  end

  private

  def account_validation
    result = false
    if /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i.match(account)
      result = true
    end

    if /^1[3|4|5|8]\d{9}$/.match(account)
      return true
    end

    errors[:account] << "帐号必须为邮箱或手机号" unless result
  end
end