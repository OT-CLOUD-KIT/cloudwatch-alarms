instance_cpu_alarm = {
  alarm_actions       = ["arn:aws:sns:us-east-1:509633460021:demo"]
  alarm_description   = "Alarm for CPU utilization more than 75%"
  alarm_name          = "instance-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 5
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  extended_statistic  = "p90"
  instance_id         = "i-0cf11703b486c578e"
  tags = {
    Purpose = "CPU_Utilization"
  }
  threshold = 75
}


instance_cpu_alarm_statistic = {
  alarm_actions       = ["arn:aws:sns:us-east-1:509633460021:demo"]
  alarm_description   = "Alarm for CPU utilization more than 75%"
  alarm_name          = "cpu-utilization-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 5
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  instance_id         = "i-0cf11703b486c578e"
  tags = {
    Purpose = "CPU_Utilization"
  }
  threshold = 75
}


httpcode_lb_5xx_count_alerts_details = {
  alarm_actions       = ["arn:aws:sns:us-east-1:509633460021:demo"]
  alarm_description   = "5xx-response error is too high"
  alarm_name          = "5xx-error-rate"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 5
  threshold           = 5
  tags = {
    Purpose = "5xx-error"
  }
  metric_query = [
    {
      expression  = "m2/m1*100"
      id          = "e1"
      label       = "Error Rate"
      return_data = true
      metric      = []
    },
    {
      id = "m1"
      metric = [
        {
          dimensions = {
            LoadBalancer = "app/d-ot-bp-alb/cca02c1c3572ccca"
          }
          metric_name = "RequestCount"
          namespace   = "AWS/ApplicationELB"
          period      = 120
          stat        = "Sum"
          unit        = "Count"
        }
      ]
    },
    {
      id = "m2"
      metric = [
        {
          dimensions = {
            LoadBalancer = "app/d-ot-bp-alb/cca02c1c3572ccca"
          }
          metric_name = "HTTPCode_ELB_5XX_Count"
          namespace   = "AWS/ApplicationELB"
          period      = 120
          stat        = "Sum"
          unit        = "Count"
        }
      ]
    }
  ]
}


# Naming & Tagging
# -----------------------------------------
bu       = "bp"
program  = "ot"
team     = "devops"
app      = "ot"
env      = "d"
region   = "us-east-1"
resource = "cloud-watch"
