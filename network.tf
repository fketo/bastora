
//vpc
resource "aws_vpc" "vpc-demo-ec3" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_support = "true" 
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  instance_tenancy = "default"
  tags = {
    Name = "vpc-demo-ec3"
    }
   }


//subnets
resource "aws_subnet" "subnets-public" {
  count = length(var.public_subnets_cidr)
  vpc_id            = aws_vpc.vpc-demo-ec3.id
  cidr_block        = element(var.public_subnets_cidr,count.index)
  availability_zone = element(var.aws_availability_zones,count.index)
  map_public_ip_on_launch = "true"
  tags = {
    Name = "subnets-public"
    }
  }

resource "aws_subnet" "subnets-private" {
  count = length(var.private_subnets_cidr)
  vpc_id            = aws_vpc.vpc-demo-ec3.id
  cidr_block        = element(var.private_subnets_cidr,count.index)
  availability_zone = element(var.aws_availability_zones,count.index)
  map_public_ip_on_launch = "true"
  tags = {
    Name = "subnets-private"
    }
  }

//DB Subnet group
resource "aws_db_subnet_group" "sng-ora" {
  name        = "sng-ora"
  subnet_ids  = aws_subnet.subnets-private.*.id
}

//internet gateway
  resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-demo-ec3.id
  tags = {
    Name = "igw"
    }
  }



//routing table
resource "aws_route_table" "route_public" {
  vpc_id = aws_vpc.vpc-demo-ec3.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    }
  tags = {
    Name = "route_public"
    }
}

//add route to routing table
resource "aws_route_table_association" "rta_subnet_public" {
  count = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.subnets-public.*.id,count.index)
  route_table_id = aws_route_table.route_public.id
}


//security group public
resource "aws_security_group" "sg_public" {
  name = "sg_public"
  vpc_id = aws_vpc.vpc-demo-ec3.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg_public"
    }
}

//security group private
resource "aws_security_group" "sg_private" {
  name = "sg_private"
  vpc_id = aws_vpc.vpc-demo-ec3.id
  ingress {
    from_port   = 1521
    to_port     = 1521
    protocol    = "tcp"
    security_groups = ["${aws_security_group.sg_public.id}"]
  }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg_private"
    }
}

/*
//loadbalancer
resource "aws_elb" "elb" {
  name               = "elb"
  subnets = aws_subnet.subnet-pub01.*.id
  security_groups = [aws_security_group.sg_public.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.php"
    interval            = 30
  }

  instances                   = [aws_instance.ec2_pub[0].id, aws_instance.ec2_pub[1].id]
  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    Name = "terraform-elb"
  }

}
*/