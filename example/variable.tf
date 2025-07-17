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



variable "env" {
  description = "Environment short name. Must be one of: d (dev), p (prod), q (qa), s (stage), g (global)."
  type        = string
  default     = "d"
  validation {
    condition     = contains(["d", "p", "q", "s", "g"], var.env)
    error_message = "env must be one of 'd', 'p', 'q', 's', 'g'."
  }
}

variable "bu" {
  description = "Business unit name (e.g., pcs, ultrasound). Max 5 characters."
  type        = string
  default     = "ot"
  validation {
    condition     = length(var.bu) <= 5
    error_message = "The business unit name must be less than or equal to 5 characters."
  }
}

variable "app" {
  description = "Application name (e.g., network, shared). Max 6 characters."
  type        = string
  default     = "bp"
  validation {
    condition     = length(var.app) <= 6
    error_message = "The app name must be less than or equal to 6 characters."
  }
}

variable "resource" {
  description = "Resource name (e.g., eks, efs, ecr). Max 15 characters."
  type        = string
  default     = "instance"
  validation {
    condition     = length(var.resource) <= 15
    error_message = "The resource name must be less than or equal to 15 characters."
  }
}

variable "tenant" {
  description = "Tenant name (e.g., app1, app2). Max 6 characters."
  type        = string
  default     = ""
  validation {
    condition     = length(var.tenant) <= 6
    error_message = "The tenant name must be less than or equal to 6 characters."
  }
}

variable "enabled_features" {
  type    = list(string)
  default = []
}

variable "random_alphanumeric_len" {
  description = "The length of random alphanumeric string desired. Min: 1, Max: 4."
  type        = number
  default     = 4
  validation {
    condition     = var.random_alphanumeric_len >= 1 && var.random_alphanumeric_len <= 4
    error_message = "The length must be between 1 and 4."
  }
}

variable "special" {
  description = "Include special characters like !@#$%&*()-_=+[]{}<>:? in the generated name."
  type        = bool
  default     = false
}

variable "upper" {
  description = "Include uppercase characters in the generated name."
  type        = bool
  default     = false
}

variable "number" {
  description = "Include numbers in the generated name."
  type        = bool
  default     = true
}

variable "gen_no_of_names" {
  description = "Number of names to generate."
  type        = number
  default     = 1
}

variable "team" {
  description = "The email address of the team who owns the application, ex:digitalops@gehealthcare.com"
  type        = string
  default     = "infra"
}

variable "program" {
  description = "Name of the Program, For ex: OT, BP etc."
  type        = string
  default     = "ot"
}

variable "region" {
  type    = string
  default = "us-east-1"
}
