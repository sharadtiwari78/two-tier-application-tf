resource "aws_autoscaling_group" "asg" {
  name                      = "${var.project_name}-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  force_delete              = var.force_delete
  vpc_zone_identifier       = var.vpc_zone_identifier
  target_group_arns         = [var.target_group_arns]

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = var.metrics_granularity

  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }
}
#scale up
resource "aws_autoscaling_policy" "scale_up_policy" {
  name                   = "${var.project_name}-scale-up-policy"
  scaling_adjustment     = var.scaling_adjustment_up #increasing instance by 1
  adjustment_type        = var.adjustment_type
  cooldown               = var.cooldown
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

#Scale Down
resource "aws_autoscaling_policy" "scale_down_policy" {
  name                   = "${var.project_name}-scale-down-policy"
  scaling_adjustment     = var.scaling_adjustment_down #decreasing instance by 1 
  adjustment_type        = var.adjustment_type
  cooldown               = var.cooldown
  autoscaling_group_name = aws_autoscaling_group.asg.name
}