resource "aws_cloudwatch_metric_alarm" "service" {
  alarm_name                = var.alarm_name
  comparison_operator       = var.comparison_operator
  evaluation_periods        = var.evaluation_periods
  metric_name               = var.metric_name
  namespace                 = var.namespace
  period                    = var.period
  statistic                 = var.statistic != null ? var.statistic : null
  extended_statistic        = var.statistic == null ? var.extended_statistic : null
  threshold                 = var.threshold
  alarm_description         = var.alarm_description
  dimensions                = var.dimensions
  treat_missing_data        = var.treat_missing_data
  alarm_actions             = var.alarm_actions
  tags                      = var.tags
  insufficient_data_actions = var.insufficient_data_actions

  dynamic "metric_query" {
    for_each = var.metric_name == null && var.namespace == null && var.dimensions == null && var.period == null ? var.metric_query : []
    content {
      id          = metric_query.value.id
      account_id  = metric_query.value.account_id
      expression  = metric_query.value.expression
      label       = metric_query.value.label
      period      = metric_query.value.period
      return_data = metric_query.value.return_data

      dynamic "metric" {
        for_each = metric_query.value.expression == null ? metric_query.value.metric : []
        content {
          dimensions  = metric.value.dimensions
          metric_name = metric.value.metric_name
          namespace   = metric.value.namespace
          period      = metric.value.period
          stat        = metric.value.stat
          unit        = metric.value.unit
        }
      }
    }
  }
}
