resource "aws_launch_template" "ec2_instance" {
  name_prefix   = "priya-web-launch-template"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type["test"]

  key_name               = "priya"
  vpc_security_group_ids = [aws_security_group.alb_sg.id]
 user_data = base64encode(<<EOF
#!/bin/bash
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "Hello from Auto Scaling" > /var/www/html/index.html
EOF
)
}