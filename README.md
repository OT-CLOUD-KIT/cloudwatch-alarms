# Terraform AWS CloudWatch Alarm

A Terraform module to provision configurable **AWS CloudWatch Alarms** using standard naming conventions and tagging. Supports:

- Basic and extended statistics
- Custom metrics via `metric_query`
- Anomaly detection
- Dynamic naming and tagging using OT Cloud Kit standards

---

## Feature
> This module supports creating CloudWatch alarms using:
> - Basic metrics (e.g., `Average`, `Sum`)
> - Extended statistics (e.g., `p95`, `p99`)
> - Complex `metric_query` expressions  
> All alarms are tagged consistently and named using a centralized naming convention module.

---

## Architecture
<img width="715" height="498" alt="image" src="https://github.com/user-attachments/assets/30d5f199-274a-4a7d-be75-782cfce24a13" />


## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.82.2   |
| <a name="terraform_module"></a> [Terraform](Terraform\module) | >= 1.12.1|

---


## Usage


```hcl
module "cloudwatch" {
  source              = "git@github.com:OT-CLOUD-KIT/cloudwatch-alarms.git?ref=Feature"
  alarm_name          = "i-0cf11703b486c578e-instance-cpu-high-alerts"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 5
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  extended_statistic  = "p90"
  threshold           = 75
  alarm_description   = "Alarm for CPU utilization more than 75%"
  alarm_actions       = ["arn:aws:sns:us-east-1:509633460021:demo"]
  tags = {
    Purpose = "CPU_Utilization"
  }

  dimensions = {
    InstanceId = "i-0cf11703b486c578e"
  }
}

module "statistic" {
  source              = "git@github.com:OT-CLOUD-KIT/cloudwatch-alarms.git?ref=Feature"
  alarm_name          = "i-0cf11703b486c578e-cpu-utilization-alarm-alerts"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 5
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 75
  alarm_description   = "Alarm for CPU utilization more than 75%"
  alarm_actions       = ["arn:aws:sns:us-east-1:509633460021:demo"]
  tags = {
    Purpose = "CPU_Utilization"
  }

  dimensions = {
    InstanceId = "i-0cf11703b486c578e"
  }
}

module "custom_metrics" {
  source              = "git@github.com:OT-CLOUD-KIT/cloudwatch-alarms.git?ref=Feature"
  alarm_name          = "5xx-error-rate-alerts"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 5
  threshold           = 5
  alarm_description   = "5xx-response error is too high"
  alarm_actions       = ["arn:aws:sns:us-east-1:509633460021:demo"]
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


```


> **Note:**  
> The above example demonstrates how to use the module. All variables, resources, and outputs used here are already defined within this module.


## Resources


| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |



## Input


| Name                                                                                                           | Description                                              | Type           | Default     | Required |
| -------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------- | -------------- | ----------- | :------: |
| <a name="input_alarm_name"></a> [alarm\_name](#input_alarm_name)                                               | Name suffix for the alarm (prepended by standard naming) | `string`       | n/a         |    Yes   |
| <a name="input_comparison_operator"></a> [comparison\_operator](#input_comparison_operator)                    | Comparison operator to use for the alarm                 | `string`       | n/a         |    Yes   |
| <a name="input_evaluation_periods"></a> [evaluation\_periods](#input_evaluation_periods)                       | Number of evaluation periods                             | `number`       | n/a         |    Yes   |
| <a name="input_metric_name"></a> [metric\_name](#input_metric_name)                                            | Metric name (optional if `metric_query` is used)         | `string`       | `null`      |    No   |
| <a name="input_namespace"></a> [namespace](#input_namespace)                                                   | Metric namespace (optional if `metric_query` is used)    | `string`       | `null`      |    No   |
| <a name="input_period"></a> [period](#input_period)                                                            | Period in seconds for the metric evaluation              | `number`       | `60`        |    Yes   |
| <a name="input_statistic"></a> [statistic](#input_statistic)                                                   | Statistic to apply (e.g., Average, Maximum)              | `string`       | `null`      |    No   |
| <a name="input_extended_statistic"></a> [extended\_statistic](#input_extended_statistic)                       | Used instead of `statistic` (e.g., p90)                  | `string`       | `null`      |    No   |
| <a name="input_threshold"></a> [threshold](#input_threshold)                                                   | Threshold to trigger alarm                               | `number`       | n/a         |    Yes   |
| <a name="input_alarm_description"></a> [alarm\_description](#input_alarm_description)                          | Description for the alarm                                | `string`       | `null`      |    No   |
| <a name="input_alarm_actions"></a> [alarm\_actions](#input_alarm_actions)                                      | List of ARN actions to trigger on alarm                  | `list(string)` | `[]`        |    No   |
| <a name="input_insufficient_data_actions"></a> [insufficient\_data\_actions](#input_insufficient_data_actions) | Actions to execute when insufficient data is detected    | `list(string)` | `[]`        |    No   |
| <a name="input_treat_missing_data"></a> [treat\_missing\_data](#input_treat_missing_data)                      | Handling method for missing data                         | `string`       | `"missing"` |    No   |
| <a name="input_dimensions"></a> [dimensions](#input_dimensions)                                                | Dimensions for the metric (e.g., InstanceId)             | `map(string)`  | `{}`        |    No   |
| <a name="input_metric_query"></a> [metric\_query](#input_metric_query)                                         | List of metric queries (for composite/custom metrics)    | `any`          | `[]`        |    No   |
| <a name="input_bu"></a> [bu](#input_bu)                                                                        | Business Unit name                                       | `string`       | n/a         |    Yes   |
| <a name="input_program"></a> [program](#input_program)                                                         | Program name                                             | `string`       | n/a         |    Yes   |
| <a name="input_app"></a> [app](#input_app)                                                                     | Application name                                         | `string`       | n/a         |    Yes   |
| <a name="input_env"></a> [env](#input_env)                                                                     | Environment (e.g., dev, prod)                            | `string`       | n/a         |    Yes   |
| <a name="input_team"></a> [team](#input_team)                                                                  | Team responsible for the resource                        | `string`       | n/a         |    Yes   |
| <a name="input_region"></a> [region](#input_region)                                                            | AWS region                                               | `string`       | n/a         |    Yes   |


___


## Outputs

| Name                                                                 | Description                              |
|----------------------------------------------------------------------|------------------------------------------|
| <a name="output_cloudwatch_arn"></a> [cloudwatch_arn](#output_cloudwatch_arn) | The ARN of the created CloudWatch alarm. |




## Contributors

- [Piyush Upadhyay](https://github.com/piiiyuushh)
- [Nikita Joshi](https://github.com/jnikita19)
