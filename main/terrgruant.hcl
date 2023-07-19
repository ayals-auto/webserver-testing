remote_state {
  backend = "s3"
  config = {
    bucket         = "web-server-deplyment"
    key            = "terragrunt/wordpress/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "my-lock-table"
  }
}