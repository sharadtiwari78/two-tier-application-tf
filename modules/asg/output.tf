output "asg_name" {
  value = aws_autoscaling_group.asg.name
}

output "scale_up_policy_arn" {
  value = aws_autoscaling_policy.scale_up_policy.arn
}

output "scale_down_policy_arn" {
  value = aws_autoscaling_policy.scale_down_policy.arn
}