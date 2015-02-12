class ImpUser < Importex::Base  
  column "帐号", :required => true  
  column "姓名", :required => true   
  column "密码", :required => true  
end