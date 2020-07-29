locals {
  iam_role_arn = "arn:aws:iam::${data.aws_caller_identity.receiver.account_id}:role/${var.resource_prefix}-logs-to-kinesis"
}

resource "aws_kinesis_stream" "this" {
  provider = "aws.receiver"
  name = "${var.resource_prefix}-events"
  shard_count = var.kinesis_shard_count
  tags = var.default_tags
}

module "iam_role" {
  provider = "aws.receiver"
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "2.3.0"
  create_role = true
  role_requires_mfa = false
  role_name = "${var.resource_prefix}-logs-to-kinesis"
  custom_role_policy_arns = [aws_iam_policy.this.arn]
  trusted_role_services = ["logs.region.amazonaws.com"]
  tags = var.default_tags
}

resource "aws_iam_policy" "this" {
  provider = "aws.receiver"
  name = "${var.resource_prefix}-logs-to-kinesis"
  path = "/"
  description = "Allows cloudwatch logs to write to kinesis"
  policy = data.aws_iam_policy_document.this.json
}

data "aws_caller_identity" "receiver" {
  provider = "aws.receiver"
}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"
    actions = ["kinesis:PutRecord"]
    resources = [aws_kinesis_stream.this.arn]
  }

  statement {
    effect = "Allow"
    actions = ["iam:PassRole"]
    resources = [local.iam_role_arn]
  }
}
