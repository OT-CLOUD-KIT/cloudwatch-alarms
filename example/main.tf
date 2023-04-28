provider "aws" {
  region = "us-east-1"
}

# With Extended statistic 
module "cloudwatch" {
  source              = "./module"
  alarm_name          = "${var.instance_cpu_alarm.instance_id}-${var.instance_cpu_alarm.alarm_name}-alerts"
  comparison_operator = var.instance_cpu_alarm.comparison_operator
  evaluation_periods  = var.instance_cpu_alarm.evaluation_periods
  metric_name         = var.instance_cpu_alarm.metric_name
  namespace           = var.instance_cpu_alarm.namespace
  period              = var.instance_cpu_alarm.period
  extended_statistic  = var.instance_cpu_alarm.extended_statistic
  threshold           = var.instance_cpu_alarm.threshold
  alarm_description   = var.instance_cpu_alarm.alarm_description
  alarm_actions       = var.instance_cpu_alarm.alarm_actions
  tags                = var.instance_cpu_alarm.tags
  dimensions = {
    InstanceId = var.instance_cpu_alarm.instance_id
  }
}

# With statistic
module "statistic" {
  source              = "./module"
  alarm_name          = "${var.instance_cpu_alarm_statistic.instance_id}-${var.instance_cpu_alarm_statistic.alarm_name}-alerts"
  comparison_operator = var.instance_cpu_alarm_statistic.comparison_operator
  evaluation_periods  = var.instance_cpu_alarm_statistic.evaluation_periods
  metric_name         = var.instance_cpu_alarm_statistic.metric_name
  namespace           = var.instance_cpu_alarm_statistic.namespace
  period              = var.instance_cpu_alarm_statistic.period
  statistic           = var.instance_cpu_alarm_statistic.statistic
  threshold           = var.instance_cpu_alarm_statistic.threshold
  alarm_description   = var.instance_cpu_alarm_statistic.alarm_description
  alarm_actions       = var.instance_cpu_alarm_statistic.alarm_actions
  tags                = var.instance_cpu_alarm_statistic.tags
  dimensions = {
    InstanceId = var.instance_cpu_alarm_statistic.instance_id
  }
}

# With custom metrics
module "custom_metrics" {
  source              = "./module"
  alarm_name          = "${var.httpcode_lb_5xx_count_alerts_details.alarm_name}-alerts"
  comparison_operator = var.httpcode_lb_5xx_count_alerts_details.comparison_operator
  evaluation_periods  = var.httpcode_lb_5xx_count_alerts_details.evaluation_periods
  threshold           = var.httpcode_lb_5xx_count_alerts_details.threshold
  alarm_description   = var.httpcode_lb_5xx_count_alerts_details.alarm_description
  alarm_actions       = var.httpcode_lb_5xx_count_alerts_details.alarm_actions
  tags                = var.httpcode_lb_5xx_count_alerts_details.tags
  metric_query        = var.httpcode_lb_5xx_count_alerts_details.metric_query
}