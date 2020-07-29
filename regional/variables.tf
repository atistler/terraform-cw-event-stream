variable "receiver_role_arn" {
  type = "string"
}
variable "resource_prefix" {
  type = "string"
}
variable "iam_role_arn" {
  type = "string"
}
variable "kinesis_stream_arn" {
  type = "string"
}
variable "destination_arn" {
  type = "string"
}
variable "cloudwatch_log_group_retention_in_days" {
  type = "string"
  default = 7
}
variable "default_tags" {
  type = map(string)
  default = {}
}
variable "cloudwatch_log_subscription_filter_pattern" {
  type = "string"
  default = ""
}

