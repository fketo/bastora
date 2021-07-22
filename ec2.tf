//ec2

resource "aws_instance" "ec2_pub" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id = "${element(aws_subnet.subnets-public.*.id,count.index)}"
  count = "${length(var.public_subnets_cidr)}" 
  vpc_security_group_ids = [aws_security_group.sg_public.id]
  key_name = "myssh"
  

 tags = {
  Name = "ec2_pub"
 }
}



/*
user_data = <<-EOF
#! /bin/bash
sudo yum install httpd php -y
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<?php echo 'Hello WOrld '; echo \$_SERVER['SERVER_ADDR']; ?>"| sudo tee /var/www/html/index.php
sudo rm /var/www/html/index.html
EOF
*/