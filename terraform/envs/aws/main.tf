## VPCの設定
resource "aws_vpc" "adachin-web_vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    tags {
     Name = "adachin-web_vpc"
   }
}
 
##サブネットの作成(1a)
resource "aws_subnet" "public-a" { 
    vpc_id = "${aws_vpc.adachin-web_vpc.id}"
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-northeast-1a"
    tags {
     Name = "adachin-web_1a"
   }
}
 
##サブネットの追加(1c)
resource "aws_subnet" "public-c" { 
    vpc_id = "${aws_vpc.adachin-web_vpc.id}"
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-northeast-1c"
    tags {
     Name = "adachin-web_1c"
   }
}
 
##ルートテーブルの作成(1a)
resource "aws_route_table_association" "puclic-a" {
    subnet_id = "${aws_subnet.public-a.id}" #上記のサブネットを変数定義
    route_table_id = "${aws_route_table.public-route.id}" #上記のルートテーブルを変数定義
}
 
##ルートテーブルの作成(1c)
resource "aws_route_table_association" "puclic-c" {
    subnet_id = "${aws_subnet.public-c.id}"
    route_table_id = "${aws_route_table.public-route.id}"
}
 
##ゲートウェイの設定
resource "aws_internet_gateway" "adachin-web_GW" {
    vpc_id = "${aws_vpc.adachin-web_vpc.id}" #上記のVPCを変数定義
}
 
##ルートテーブルの追加(0.0.0.0/0)
resource "aws_route_table" "public-route" {
    vpc_id = "${aws_vpc.adachin-web_vpc.id}"
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.adachin-web_GW.id}"
   }
}
 
#セキュリティーグループの設定
resource "aws_security_group" "adachin-web" {
    name = "adachin-web"
    description = "adachin-web"
    vpc_id = "${aws_vpc.adachin-web_vpc.id}"
    ingress {
      from_port = 80 
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["許可したいIP"]
 }
    ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["許可したいIP"]
 }
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
 }
    tags {
      Name = "adachin-web"
   }
}
 
##EC2の構築(adachin-web01)
resource "aws_instance" "adachin-web01" {
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    key_name = "adachin"
    vpc_security_group_ids = ["${aws_security_group.adachin-web.id}"] #上記のセキュリティグループIDを変数定義
    subnet_id = "${aws_subnet.public-a.id}" #同じく上記のサブネットIDを変数定義
    ebs_block_device = {
      device_name = "/dev/sdf"
      volume_type = "gp2"
      volume_size = "30"
    }
    tags {
     Name = "adachin-web01"
   }
}
 
##EIPの紐付け(adachin-web01)
resource "aws_eip" "adachin-web01" {
    instance = "${aws_instance.adachin-web01.id}"
    vpc = true
}
