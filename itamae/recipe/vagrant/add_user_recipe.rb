user "adachin" do
   action :create
   username "adachin"
   home "/home/adachin"
   password "hoge"
 end
 
 #make a key
 USER_NAME = "adachin"
 SSH_PUBKEY = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCvH4RmctCYeq6DXm7OvKGwZuVnJVLBC2OzolEhkQfwBkYtgRjzMTc+vSyfuHadN2vK2zcVj75H5hamVa5KO8SUUyW5FATzq3Yo8Rl07mdD0eUaB6gc4672tL54+AhAfAnUsdO0ieWJ/72Tno6xkspRZLZXB/D0SPlL7YghnhT6tSRV2kEJeCam/2etjOvr6ZIzN/N4hDjNUbWj2QSFoh6b6IaCi6XMtup8xq8qG1mwbNXKK8sZU1jEjGszYe8KPYaHmUUly83ZJQYdMwBkRF64j0MqHd8oJnVG5N8h22jcbK5+hc58wvhIX5s1p5s30Ne2QEIM6W58lFMZNaSDNmLh adachiryou@RVIRUS-Macmini.local
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBp2LsogjMljY1RNAIaQqTGnPHOPZvvX3A/hTbRqJLdXqdWFLXZk/DopYD4FZ0f/i6wc148Z6XevdmML1hvIEA1VuvqEOGvmH5qqT37A6S9PFVid+XDEMI2y0FiG0++MsVoH8m88Qkkvcvb4sraUccbgCzGgIs0YYRvBasiSoFgy89hJ49qZiaznXuEuQINdCAVtxLbO30weZoTmrrSCrGsuWdTusT9kx44Hozc37Eti8KhCabGvbDeuxFD8j87zwK/MoxLqv3p2eEdVui3fUUSDjCXA6V1teaBwm8wNwfkQUprKj0KC48PliWSQ3li3hYgcc7xCUpyi4ez0Lkr+Wl adachiryou@RVIRUS-MacBook-Pro.local"

 directory "/home/#{USER_NAME}/.ssh" do
  owner USER_NAME
  group USER_NAME
  mode  "700"
end

 file "/home/#{USER_NAME}/.ssh/authorized_keys" do
   content SSH_PUBKEY
   owner USER_NAME
   group USER_NAME
   mode  "600"
 end
