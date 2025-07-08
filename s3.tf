resource "aws_s3_bucket" "terraform_state" {
  bucket = "cloudify-bucket"

  versioning {
    enabled = true
  }

  lifecycle_rule {
  enabled = true

  expiration {
    days = 30
  }
}

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "TerraformStateBucket"
    Environment = "Dev"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name           = "terraform-locks"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "TerraformLocks"
    Environment = "Dev"
  }
}
