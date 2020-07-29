output "iam_role_arn" {
  value = module.iam_role.this_iam_role_arn
}
output "kinesis_stream_arn" {
  value = aws_kinesis_stream.this.arn
}
