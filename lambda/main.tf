resource "aws_lambda_function" "lam" {
  function_name    = var.lambda_function_name
  handler          = "${var.file_name}.${var.python_function_name}"
  runtime          = var.runtime
  role             = var.iam_role_arn
  filename         = var.zip_file_path
  source_code_hash = filebase64sha256(var.zip_file_path)
  tags = {
    Name        = var.lambda_function_name
    environment = var.environment
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = var.iam_role_name
  assume_role_policy = var.assume_role_policy
  tags = {
    Name        = var.iam_role_name
    environment = var.environment
  }
}


resource "aws_iam_policy" "lambda_execution" {
  name   = var.policy_name
  policy = var.policy
  tags = {
    Name        = var.policy_name
    environment = var.environment
  }
}
resource "aws_iam_role_policy_attachment" "role_policy" {
  policy_arn = var.policy_arn
  role       = var.iam_role_name
  tags{
    environment=var.environment
  }
}
