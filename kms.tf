resource "aws_kms_key" "my_key" {
  description = "My KMS key"
  name = "firstkey"
  #policy      = jsonencode(data.aws_iam_policy_document.kms_policy.json)
  policy      =  data.aws_iam_policy_document.kms_policy.json
}
