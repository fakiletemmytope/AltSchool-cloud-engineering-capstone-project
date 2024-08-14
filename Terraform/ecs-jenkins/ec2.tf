resource "aws_instance" "jenkins_instance" {
  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  subnet_id              = aws_subnet.public_subnet.id

  tags = {
    Name = "Jenkins-server"
  }


  key_name = "jenkins-server-key"


  user_data = file("jenkins-installations.sh")
}