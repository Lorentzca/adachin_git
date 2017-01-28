
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
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
