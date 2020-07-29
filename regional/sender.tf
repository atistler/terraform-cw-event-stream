resource "aws_cloudwatch_event_rule" "this" {
  name = "${var.resource_prefix}-event-forwarding"
  description = "${var.resource_prefix}-event-forwarding"
  event_pattern = <<PATTERN
{
  "source": ["aws.ec2"]
}
PATTERN
  tags = var.default_tags
}

resource "aws_cloudwatch_event_target" "this" {
  target_id = "${var.resource_prefix}-event-forwarding"
  rule = aws_cloudwatch_event_rule.this.name
  arn = aws_cloudwatch_log_group.this.arn
}

resource "aws_cloudwatch_log_group" "this" {
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  name = "/aws/events/${var.resource_prefix}-event-forwarding"
  tags = var.default_tags
}

resource "aws_cloudwatch_log_subscription_filter" "this" {
  destination_arn = var.destination_arn
  log_group_name = aws_cloudwatch_log_group.this.name
  name = "${var.resource_prefix}-filter"
  filter_pattern = var.cloudwatch_log_subscription_filter_pattern
}

data "aws_caller_identity" "sender" {}
