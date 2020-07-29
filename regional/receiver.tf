resource "aws_cloudwatch_log_destination" "this" {
  provider = "aws.receiver"
  name = "${var.resource_prefix}-event-forwarding"
  role_arn = var.iam_role_arn
  target_arn = var.kinesis_stream_arn
  tags = var.default_tags
}

resource "aws_cloudwatch_log_destination_policy" "this" {
  provider = "aws.receiver"
  destination_name = aws_cloudwatch_log_destination.this.name
  access_policy = data.aws_iam_policy_document.access_policy.json
}

data "aws_iam_policy_document" "access_policy" {
  statement {
    effect = "Allow"
    principals {
      identifiers = [data.aws_caller_identity.sender.account_id]
      type = "AWS"
    }
    actions = ["logs:PutSubscriptionFilter"]
    resources = [aws_cloudwatch_log_destination.this.arn]
  }
}


