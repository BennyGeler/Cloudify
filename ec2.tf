provider "aws" {
  region = var.region
}

# יצירת מפתח SSH
resource "aws_key_pair" "web_key" {
  key_name   = "web_key"
  public_key = file("~/.ssh/id_rsa.pub")  # שנה את הנתיב אם צריך
}

# שליפת ה-VPC ברירת מחדל (כדי להשתמש בו בסגמנט הרשת)
data "aws_vpc" "default" {
  default = true
}

# יצירת אינסטנס EC2 עם Nginx
resource "aws_instance" "web_server" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.web_key.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "WebServer"
  }
}

resource "aws_volume_attachment" "web_volume" {
  device_name = "/dev/xvdf"  # או /dev/sdf, תלוי באיזור
  volume_id   = aws_ebs_volume.web_volume.id
  instance_id = aws_instance.web_server.id
  force_detach = true
}

# Elastic IP
resource "aws_eip" "web_eip" {
  instance = aws_instance.web_server.id
  vpc      = true
}

# Outputs
output "web_server_public_ip" {
  value = aws_eip.web_eip.public_ip
}

output "web_server_url" {
  value = "http://${aws_eip.web_eip.public_ip}"
}
