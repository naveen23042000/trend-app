output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.jenkins_instance.id
}

output "public_ip" {
  description = "Public IP address of the instance"
  value       = aws_instance.jenkins_instance.public_ip
}

output "instance_state" {
  description = "Current running state of the EC2 instance"
  value       = aws_instance.jenkins_instance.instance_state
}

