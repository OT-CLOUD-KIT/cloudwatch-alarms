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

