#common
初期セットアップ、ユーザ作成、updateなど
  $ ansible-playbook site.yml -i hosts -l aws-ec2 --tags common --check
#sshd
sshd_config
  $ ansible-playbook site.yml -i hosts -l aws-ec2 --tags sshd --check
#apache,nginx
バーチャルの設定、php系も
  $ ansible-playbook site.yml -i hosts -l aws-ec2 --tags apache --check
  $ ansible-playbook site.yml -i hosts -l aws-ec2 --tags httpd-conf --check
  $ ansible-playbook site.yml -i hosts -l aws-ec2 --tags nginx --check
  $ ansible-playbook site.yml -i hosts -l aws-ec2 --tags nginx-conf --check
#--checkはdry run
