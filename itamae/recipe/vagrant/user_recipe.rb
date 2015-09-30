user "adachin" do
   action :create
 #  uid "502"
 #  gid "508"
   username "adachin"
   home "/home/adachin"
   password "hoge"
 end
 
 #make a key
 USER_NAME = "adachin"
 SSH_KEY = "ssh-rsa ~"

 directory "/home/#{USER_NAME}/.ssh" do
 end

 file "/home/#{USER_NAME}/.ssh/authorized_keys" do
   content SSH_KEY
   owner USER_NAME
   group USER_NAME
   mode  "600"
 end
