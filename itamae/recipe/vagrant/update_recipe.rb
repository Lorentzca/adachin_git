execute "update yum repo" do 
   user "root" 
    command "yum -y update" 
    command "yum -y upgrade" 
end
