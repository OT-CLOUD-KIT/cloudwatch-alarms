output "cloudwatch_alarm_arn" {
  value       = module.cloudwatch.cloudwatch_arn
  description = "CloudWatch alarm ARN for instance CPU alarm with extended statistic"
}