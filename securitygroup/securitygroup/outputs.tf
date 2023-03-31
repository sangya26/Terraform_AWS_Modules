############output of Security Groups######
output "sg_output" {
  value = aws_security_group.ec2_security_groups
}