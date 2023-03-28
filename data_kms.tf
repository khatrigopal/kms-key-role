data "aws_iam_policy_document" "kms_execution_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["kms.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "kms_policy" {
  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
    ]
     principals {
      identifiers = [aws_iam_role.kms_role.arn]
      type        = "AWS"
    }
    resources = [aws_kms_key.my_key.arn,
                aws_kms_key.my_key.arn+":*",
    ]
    
  }

}
