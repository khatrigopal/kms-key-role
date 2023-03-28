data "aws_region" "current" {}


data "aws_caller_identity" "current" {}


resource "aws_iam_role" "kms_role" {
  name = "my-kms-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "kms.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

data "aws_iam_policy_document" "kms_key_policy" {
  statement {
    effect = "Allow"

    principals {
      identifiers = [aws_iam_role.kms_role.arn]
      type        = "AWS"
    }

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
    ]

    resources = ["arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
  }
}

resource "aws_kms_key" "my_key" {
  description = "My KMS key"
  policy      = jsonencode(data.aws_iam_policy_document.kms_key_policy.json)
}

resource "aws_kms_alias" "kms_key_alias" {
  name          = "alias/tesstkey"
  target_key_id = aws_kms_key.my_key.key_id
}
