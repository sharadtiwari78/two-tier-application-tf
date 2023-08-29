resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name          = "${var.project_name}-scale-up-alarm"
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold_up
  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
  actions_enabled = true
  alarm_actions   = [var.asg_scale_up_policy_arn]
}

resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name          = "${var.project_name}-scale-down-alarm"
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold_down
  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
  actions_enabled = true
  alarm_actions   = [var.asg_scale_down_policy_arn]
}
