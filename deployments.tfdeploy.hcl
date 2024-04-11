# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

identity_token "aws" {
  audience = ["aws.workload.identity"]
}

# A single workload token can be trusted by multiple accounts - but optionally, you can generate a
# separate token with a difference audience value for your second account and use it below.
#
# identity_token "account_2" {
#   audience = ["<Set to your AWS IAM assume-role audience>"]
# }

deployment "development" {
  variables = {
    region              = "us-east-1"
    role_arn            = "arn:aws:iam::886363944443:role/Terraform-OIDC"
    identity_token_file = identity_token.aws.jwt_filename
    default_tags      = { stacks-preview-example = "lambda-multi-account-stack" }
  }
}

deployment "production" {
  variables = {
    region              = "us-east-1"
    role_arn            = "arn:aws:iam::886363944443:role/Terraform-OIDC-2"
    identity_token_file = identity_token.aws.jwt_filename
    default_tags      = { stacks-preview-example = "lambda-multi-account-stack" }
  }
}
