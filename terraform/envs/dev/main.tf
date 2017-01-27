## VPCの設定
resource "aws_vpc" "adachin-dev_vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    tags {
      Name = "adachin-dev_vpc"
    }
}

##サブネットの作成(1a)
resource "aws_subnet" "public-a" { 
	vpc_id = "${aws_vpc.adachin-dev_vpc.id}"
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-northeast-1a"
    tags {
      Name = "adachin-dev_1a"
    }
}

##サブネットの追加(1c)
resource "aws_subnet" "public-c" { 
	vpc_id = "${aws_vpc.adachin-dev_vpc.id}"
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-northeast-1c"
    tags {
      Name = "adachin-dev_1c"
    }
}

##ルートテーブルの作成(1a)
resource "aws_route_table_association" "puclic-a" {
    subnet_id = "${aws_subnet.public-a.id}"
    route_table_id = "${aws_route_table.public-route.id}"
}

##ルートテーブルの作成(1c)
resource "aws_route_table_association" "puclic-c" {
    subnet_id = "${aws_subnet.public-c.id}"
    route_table_id = "${aws_route_table.public-route.id}"
}

##ゲートウェイの設定
resource "aws_internet_gateway" "adachin-dev_GW" {
    vpc_id = "${aws_vpc.adachin-dev_vpc.id}"
}

##ルートテーブルの追加(0.0.0.0/0)
resource "aws_route_table" "public-route" {
    vpc_id = "${aws_vpc.adachin-dev_vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.adachin-dev_GW.id}"
    }
}

#セキュリティーグループの設定
resource "aws_security_group" "adachin-dev" {
    name = "adachin-dev"
    description = "game-adachin-dev"
    vpc_id = "${aws_vpc.adachin-dev_vpc.id}"
    ingress {
        from_port = 80 
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["xxxxxx/x"]
    }
    egress {
       from_port = 0
       to_port = 0
       protocol = "-1"
       cidr_blocks = ["xxxxxx/x"]
    }
    tags {
      Name = "adachin-dev"
    }
}

##EC2の構築(adachin01)
resource "aws_instance" "adachin01" {
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    key_name = "adachin"
    vpc_security_group_ids = [
	  "${aws_security_group.adachin-dev.id}"
	]
    subnet_id = "${aws_subnet.public-a.id}"
    tags {
        Name = "adachin-dev"
    }
}

##EIPの紐付け(adachin01)
resource "aws_eip" "adachin01" {
    instance = "${aws_instance.adachin01.id}"
    vpc      = true
}
