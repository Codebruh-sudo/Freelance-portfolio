provider "aws" {
      region = "us-east-1"  # Change to your preferred region
}

resource "aws_key_pair" "deployer" {
      key_name   = "ec2-key"
        public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "web_sg" {
      name_prefix = "ec2-secure-"
        description = "Allow SSH and HTTP"

          ingress {
                from_port   = 22
                    to_port     = 22
                        protocol    = "tcp"
                            cidr_blocks = ["YOUR_IP/32"]  # Restrict to your IP
          }

            egress {
                    from_port   = 0
                        to_port     = 0
                            protocol    = "-1"
                                cidr_blocks = ["0.0.0.0/0"]
            }
}

resource "aws_instance" "secure_ec2" {
      ami           = "ami-0c02fb55956c7d316" # Example Amazon Linux 2 AMI (update if needed)
        instance_type = "t2.micro"
          key_name      = aws_key_pair.deployer.key_name
            security_groups = [aws_security_group.web_sg.name]

              user_data = file("init.sh")  # Bootstrap script

                tags = {
                        Name = "Secure-EC2"
                }
}

                }
}
            }
          }
}
}
}