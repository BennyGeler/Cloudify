resource "aws_ebs_volume" "web_volume" {
  availability_zone = var.availability_zone  # ⚠️ לתאם עם תלמיד 1 – באיזה AZ ה-EC2 נמצא
  size              = 10

  tags = {
    Name = "WebVolume"
  }
}

resource "aws_volume_attachment" "web_volume_attachment" {
  device_name = "/dev/xvdf"  # שם הדיסק במכונה. לא לשנות לרוב.
  volume_id   = aws_ebs_volume.web_volume.id
  instance_id = var.instance_id  # ⚠️ לתאם עם תלמיד 1 – מה ה-ID של ה-EC2?
}
