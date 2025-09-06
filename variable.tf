variable "alarm_actions" {
  type        = list(string)
  default     = ["arn:aws:sns:us-east-1:509633460021:demo"]
  description = "List of the actions that will perform when alarm trigged"
}

variable "treat_missing_data" {
  type        = string
  default     = "missing"
  description = "For missing data in metrics"
}

variable "alarm_name" {
  type        = string
  default     = "instance-cpu-high"
  description = "Name of Cloudwatch alarm"
}

variable "comparison_operator" {
  type        = string
  default     = "GreaterThanThreshold"
  description = "Comparison with threshold"
}

variable "evaluation_periods" {
  type        = number
  default     = 5
  description = "Evaluation period"
}

variable "metric_name" {
  type        = string
  default     = CPUUtilization
  description = "Name of metrics"
}

variable "namespace" {
  type        = string
  default     = "AWS/EC2"
  description = "Namespace for the metrics"
}

variable "period" {
  type    = number
  default = 60
}

variable "statistic" {
  type        = string
  default     = "Average"
  description = "Statistic such as Sum, Average etc"
}

variable "extended_statistic" {
  type        = string
  default     = "p90"
  description = "Extended statistic such as p90,p95,p99 etc"
}

variable "threshold" {
  type        = number
  default     = 75
  description = "Threshold for the metrics"
}

variable "alarm_description" {
  type        = string
  default     = "cloudwatch alarm"
  description = "Description of Cloudwatch alarm"
}

variable "dimensions" {
  type        = map(string)
  default     = {
    InstanceId = "i-0cf11703b486c578e"
  }
  description = "Dimensions for the metric (e.g., InstanceId, LoadBalancer)"
}


variable "tags" {
  type        = map(string)
  default     = {
    Purpose = "CPU_Utilization"
  }
  description = "Tags to associate with the CloudWatch alarm"
}

variable "insufficient_data_actions" {
  type        = list(string)
  default     = null
  description = "Action to be perform when data is insufficient"
}

variable "metric_query" {
  type = list(object({
    id          = string
    account_id  = optional(string, null)
    expression  = optional(string, null)
    label       = optional(string, null)
    period      = optional(number, null)
    return_data = optional(bool, false)

    metric = optional(list(object({
      dimensions  = map(string)
      metric_name = string
      namespace   = string
      period      = number
      stat        = string
      unit        = string
    })))
  }))
  default     = []
  description = "Variables for the creating custom metrics with available metrics in AWS"
}


#############################333
variable "ok_actions" {
  description = "Actions to execute when the alarm state goes from ALARM to OK"
  type        = list(string)
  default     = []
}

variable "datapoints_to_alarm" {
  description = "Number of datapoints within the evaluation period that must be breaching"
  type        = number
  default     = null
}

variable "actions_enabled" {
  description = "Whether actions should be executed during any changes to the alarm state"
  type        = bool
  default     = true
}

variable "threshold_metric_id" {
  description = "Use when using metric math/anomaly detection"
  type        = string
  default     = ""
}



variable "env" {
  type = string
  default = "dev"
  
}

variable "owner" {
  type = string
  default = "opstree"
}

variable "app" {
  type = string
  default = "otcloud-kit"
  
}