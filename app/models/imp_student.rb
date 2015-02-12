class ImpStudent < Importex::Base  
  column "帐号", :required => true  
  column "姓名", :required => true   
  column "密码", :required => true    
  column "班级", :required => true
  column "入学年份", :required => true, :type => Integer
  column "家长帐号", :required => true  
  column "家长姓名", :required => true   
  column "家长密码", :required => true  
end