resource "aws_kms_key" "my_key" {
  description = "My KMS key"
  policy      = jsonencode(data.aws_iam_policy_document.kms_key_policy.json)
}
