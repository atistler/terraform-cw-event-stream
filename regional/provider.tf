provider "aws" {
  alias = "receiver"
  assume_role {
    role_arn = var.receiver_role_arn
  }
}
