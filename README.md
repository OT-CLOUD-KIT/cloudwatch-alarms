# Terraform AWS CloudWatch Alarm

A Terraform module to provision configurable **AWS CloudWatch Alarms** using standard naming conventions and tagging. Supports:

- Basic and extended statistics
- Custom metrics via `metric_query`
- Anomaly detection
- Dynamic naming and tagging using OT Cloud Kit standards

---

## Architecture

> This module supports creating CloudWatch alarms using:
> - Basic metrics (e.g., `Average`, `Sum`)
> - Extended statistics (e.g., `p95`, `p99`)
> - Complex `metric_query` expressions  
> All alarms are tagged consistently and named using a centralized naming convention module.

---

## Architecture

![alt text](image.png)

## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.82.2   |
| <a name="terraform_module"></a> [Terraform](Terraform\module) | >= 1.12.1|

---

## Usage


```hcl
module "statistic_alarm" {
  source              = "git@github.com:OT-CLOUD-KIT/terraform-aws-cloudwatch-alarm.git?ref=main"

  alarm_name          = "high-cpu-alerts"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 75
  dimensions          = { InstanceId = "i-0abcd1234ef567890" }

  alarm_description   = "Alert if CPU usage exceeds 75%"
  alarm_actions       = ["arn:aws:sns:us-east-1:123456789012:alerts"]

  # Standard Tags
  bu      = "OT"
  program = "CloudKit"
  app     = "WebApp"
  env     = "prod"
  team    = "DevOps"
  region  = "us-east-1"
}


```

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
