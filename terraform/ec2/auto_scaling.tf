resource "aws_launch_template" "template" {
  name_prefix   = "template"
  image_id      = "ami-0440d3b780d96b29d"
  instance_type = var.instance_type
  key_name      = var.key_pair
}

resource "aws_autoscaling_group" "main" {
  name = "main"
  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
  desired_capacity          = var.asg_desired
  max_size                  = var.asg_max
  min_size                  = var.asg_min
  min_elb_capacity          = var.asg_min
  vpc_zone_identifier       = [data.aws_subnet.private[0].id, data.aws_subnet.private[1].id]
  default_instance_warmup   = 180
  health_check_grace_period = 600
  health_check_type         = "EC2"

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}

# Autoscaling policies and Cloudwatch alarms

# Scale on CPU
resource "aws_autoscaling_policy" "high_cpu" {
  count = local.default

  name                   = "${var.app}-high-cpu-scaleup"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.main.name
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  count = local.default

  alarm_name          = "${var.app}-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }

  alarm_description = "CPU usage for ${aws_autoscaling_group.main.name} ASG"
  alarm_actions     = [aws_autoscaling_policy.high_cpu[count.index].arn]
}

resource "aws_autoscaling_policy" "low_cpu" {
  count = local.default

  name                   = "${var.app}-low-cpu-scaledown"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.main.name
}

resource "aws_cloudwatch_metric_alarm" "low-cpu" {
  count = local.default

  alarm_name          = "${var.app}-low-cpu"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "35"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }

  alarm_description = "CPU usage for ${aws_autoscaling_group.main.name} ASG"
  alarm_actions     = [aws_autoscaling_policy.low_cpu[count.index].arn]
}

##
# Autoscaling notifications
##
