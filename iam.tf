provider "aws" {
  region = "us-east-1"
}

# resource for adding new iam user
resource "aws_iam_user" "iam_user" {
    name = "Terraform_Admin_User"
}

# resource for attaching policy group to the new user
resource "aws_iam_user_policy_attachment" "iam_user_policy" {
    user = aws_iam_user.iam_user.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
