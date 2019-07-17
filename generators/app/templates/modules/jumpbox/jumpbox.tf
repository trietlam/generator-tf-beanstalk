resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2-instance" {
  count = "${var.instance_count}"
  ami = "ami-075caa3491def750b" # Amazon Linux AMI 2018.03.0 (HVM), SSD Volume Type
  instance_type = "t2.micro"

  subnet_id = "${var.subnet_id}"
  security_groups = ["${aws_security_group.allow_ssh.id}"]
  vpc_security_group_ids = "${var.security_group_ids}"

  # user_data = "${var.instance_user_data}"
  # key_name = "${var.instance_key_name}"

  tags = {
    Terraform  = true
  }
}

output "ec2_instance_id" {
  value = "${element(concat(aws_instance.ec2-instance.*.id, list("")), 0)}"
}