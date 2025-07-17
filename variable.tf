variable "alarm_actions" {
  type        = list(string)
  default     = []
  description = "List of the actions that will perform when alarm trigged"
}

variable "treat_missing_data" {
  type        = string
  default     = "missing"
  description = "For missing data in metrics"
}

variable "alarm_name" {
  type        = string
  default     = "alarm"
  description = "Name of Cloudwatch alarm"
}

variable "comparison_operator" {
  type        = string
  default     = "GreaterThanThreshold"
  description = "Comparison with threshold"
}

variable "evaluation_periods" {
  type        = number
  default     = 1
  description = "Evaluation period"
}

variable "metric_name" {
  type        = string
  default     = null
  description = "Name of metrics"
}

variable "namespace" {
  type        = string
  default     = null
  description = "Namespace for the metrics"
}

variable "period" {
  type    = number
  default = null
}

variable "statistic" {
  type        = string
  default     = null
  description = "Statistic such as Sum, Average etc"
}

variable "extended_statistic" {
  type        = string
  default     = null
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
  default     = null
  description = "About AWS resource on which cloudwatch alarm has to set"
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "Tags for Cloudwatch alarm"
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



########################### 


################################## Naming convention variables #########################################

variable "bu" {
  description = "Business unit name (e.g., BP, GURUKU). Max 6 characters."
  type        = string
  default = "BP"
  validation {
    condition     = length(var.bu) <= 6
    error_message = "The business unit name must be less than or equal to 6 characters."
  }
}

variable "program" {
  description = "Name of the program (e.g., OT, BP)."
  type        = string
  default = "OT"
}

variable "app" {
  description = "Application name (e.g., network, shared). Max 6 characters."
  type        = string
  default = "network"
  validation {
    condition     = length(var.app) <= 10
    error_message = "The app name must be less than or equal to 10 characters."
  }
}

variable "env" {
  description = "Environment code: 'd' (dev), 'p' (prod), 'q' (qa), 's' (stage), 'g' (global)."
  type        = string
  default = "d"

  validation {
    condition     = contains(["d", "p", "q", "s", "g"], var.env)
    error_message = "env must be one of 'd', 'p', 'q', 's', 'g'."
  }
}

variable "team" {
  description = "Team email responsible for the application (e.g., digitalops@gehealthcare.com)."
  type        = string
  default = "infra"
}

variable "region" {
  description = "AWS region (e.g., us-east-1, ap-south-1)."
  type        = string
  default = "us-east-1"
}
