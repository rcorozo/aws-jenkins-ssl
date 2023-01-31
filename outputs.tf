output "instance_public_ip" {
  value = aws_instance.master-jenkins.public_ip
}