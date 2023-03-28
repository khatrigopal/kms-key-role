resource "aws_iam_role" "kms_role" {
  name               = "kms-iam-role"
  assume_role_policy = data.aws_iam_policy_document.kms_execution_role.json
}

resource "aws_iam_policy" "kms_execution_policy" {
  name   = "${local.service_name}-iam-policy-stepfunction-execution"
  policy = data.aws_iam_policy_document.kms_policy.json
}

resource "aws_iam_role_policy_attachment" "kms_custom_attachment" {
  policy_arn = aws_iam_policy.kms_exectuion_policy.arn
  role       = aws_iam_role.kms_role.name
}
