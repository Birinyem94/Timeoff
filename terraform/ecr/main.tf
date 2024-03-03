resource "aws_ecr_repository" "ecr" {
  name                 = format("%s-ecr-repo", lower(var.app))
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {

      Name  = "ecr"

    }
}

## Set ECR policy only on is_mpt ECR repos (name with app-*)
resource "aws_ecr_repository_policy" "ecr" {
  count      = local.timeoff
  repository = aws_ecr_repository.ecr.name
  policy     = data.aws_iam_policy_document.ecr.json
}