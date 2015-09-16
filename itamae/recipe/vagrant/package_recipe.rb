execute "git install" do 
   user "root" 
    command "yum -y install git gcc openssl-devel readline-devel zlib-devel" 
end
