variable "receiver_role_arn" {
  type = "string"
}
variable "resource_prefix" {
  type = "string"
}
variable "default_tags" {
  type = map(string)
  default = {}
}
variable "kinesis_shard_count" {
  type = "string"
  default = 1
}
