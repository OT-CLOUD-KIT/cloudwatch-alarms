output "cloudwatch_arn" {
  value       = aws_cloudwatch_metric_alarm.service.arn
  description = "Cloudwatch alarm's arn"
}
