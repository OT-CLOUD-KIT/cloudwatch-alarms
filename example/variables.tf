variable "instance_cpu_alarm" {
  type = object({
    alarm_actions       = list(string)
    alarm_description   = string
    alarm_name          = string
    comparison_operator = string
    evaluation_periods  = number
    metric_name         = string
    namespace           = string
    period              = number
    extended_statistic  = string
    tags                = map(string)
    threshold           = number
    instance_id         = string

  })
  default = {
    alarm_actions       = []
    alarm_description   = "Alarm for CPU utilization more than 75%"
    alarm_name          = "instance"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = 5
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    period              = 60
    extended_statistic  = "p90"
    instance_id         = ""
    tags = {
      Purpose = "CPU_Utilization"
    }
    threshold = 75
  }
  description = "Cloudwatch alarm variables"
}


variable "instance_cpu_alarm_statistic" {
  type = object({
    alarm_actions       = list(string)
    alarm_description   = string
    alarm_name          = string
    comparison_operator = string
    evaluation_periods  = number
    metric_name         = string
    namespace           = string
    period              = number
    statistic           = string
    tags                = map(string)
    threshold           = number
    instance_id         = string
  })
  default = {
    alarm_actions       = []
    alarm_description   = "Alarm for CPU utilization more than 75%"
    alarm_name          = "cpu-utilization"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = 5
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    period              = 60
    statistic           = "Average"
    instance_id         = ""
    tags = {
      Purpose = "CPU_Utilization"
    }
    threshold = 75
  }
  description = "Cloudwatch alarm variables"
}

variable "httpcode_lb_5xx_count_alerts_details" {
  type = object({
    alarm_actions       = list(string)
    alarm_description   = string
    alarm_name          = string
    comparison_operator = string
    evaluation_periods  = number
    tags                = map(string)
    threshold           = number
    metric_query        = any
  })
  default = {
    alarm_actions       = []
    alarm_description   = "5xx-response error is too high"
    alarm_name          = "5xx-error"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = 5
    metric_query = [{
      expression  = "m2/m1*100"
      id          = "e1"
      label       = "Error Rate"
      return_data = true
      metric      = []
      },
      {
        id = "m1"
        metric = [{
          dimensions = {
            "LoadBalancer" = ""
          }
          metric_name = "RequestCount"
          namespace   = "AWS/ApplicationELB"
          period      = 120
          stat        = "Sum"
          unit        = "Count"
        }]
      },
      {
        id = "m2"
        metric = [{
          dimensions = {
            "LoadBalancer" = ""
          }
          metric_name = "HTTPCode_ELB_5XX_Count"
          namespace   = "AWS/ApplicationELB"
          period      = 120
          stat        = "Sum"
          unit        = "Count"
        }]
    }]
    tags = {
      Purpose = "5xx-error"
    }
    threshold = 5
  }
  description = "Cloudwatch alarm variables"
}