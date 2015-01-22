class RegMailer < ActionMailer::Base
  default from: "kuanzhengservice@163.com"

  def confirm(email, unit)
      id = unit.users.first.id
      name = unit.name
      md5str = Digest::MD5.hexdigest(id.to_s+email)
      url = "http://207.226.141.143:8080/units/active?id=#{id}&key=#{md5str}"
      message = "#{name}, 感谢您注册宽正云, 请点击下面的链接激活您的帐号: #{url}"
      #mail(:to => email, :content_type => "text/html", :subject => "宽正云注册激活邮件")
      mail(to: email,
         body: message,
         content_type: "text/html",
         subject: "宽正云注册激活邮件")
  end

  def send_pwd(user)
      message = "#{user.name}, 您在宽正云的密码为：#{user.pwd}, 请注意保管！"
      mail(to: user.account,
         body: message,
         content_type: "text/html",
         subject: "宽正云密码找回邮件")
  end
end
