resource "aws_iam_role" "role" {
  name               = "role-rapha"
  assume_role_policy = data.aws_iam_policy_document.role_policy.json
}

resource "aws_iam_role_policy_attachment" "role_policy" {
  count = length(var.role_policy_arns)

  role       = var.role_name
  policy_arn = element(var.role_policy_arns, count.index)
}