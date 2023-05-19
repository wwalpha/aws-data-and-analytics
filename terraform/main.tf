terraform {
  backend "local" {
    path = "./tfstate/terraform.tfstate"
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Provider
# ----------------------------------------------------------------------------------------------
provider "aws" {
  region = "us-east-1"
  alias  = "ResearchOwner"

  assume_role {
    role_arn = "arn:aws:iam::601711916881:role/DataMeshInfraRole"
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "Central"

  assume_role {
    role_arn = "arn:aws:iam::016725430159:role/DataMeshInfraRole"
  }
}

module "central" {
  source = "./central"
  prefix = local.prefix
  providers = {
    aws = aws.Central
  }

}

module "producer" {
  source = "./producer"
  providers = {
    aws = aws.ResearchOwner
  }

  prefix              = local.prefix
  account_id_centrail = local.account_id_centrail
}

module "centralops" {
  source = "./centralops"
  prefix = local.prefix
  providers = {
    aws = aws.Central
  }

  producer_buckets = [
    {
      raw = module.producer.s3_bucket_name_raw
    }
  ]
}

# module "iot" {
#   source                   = "./iot"
#   prefix                   = local.prefix
#   kinesis_data_stream_name = module.transform.kinesis_data_stream_name
#   iam_rule_arn_iot_rule    = module.security.iam_role_arn_iot_rule
# }

# module "networking" {
#   source = "./networking"
#   prefix = local.prefix
# }

# module "security" {
#   source = "./security"
#   prefix = local.prefix
# }

# module "storage" {
#   source = "./storage"
# }

# module "database" {
#   source                    = "./database"
#   prefix                    = local.prefix
#   vpc_id                    = module.networking.vpc_id
#   private_subnet_cidr_block = module.networking.private_subnets_cidr_blocks
#   private_subnet_ids        = module.networking.private_subnet_ids
#   database_subnet_ids       = module.networking.database_subnet_ids
#   database_username         = var.database_username
#   database_password         = var.database_password
#   iam_role_arn_rds_proxy    = module.security.iam_role_arn_rds_proxy
# }

# module "app" {
#   source                    = "./app"
#   prefix                    = local.prefix
#   vpc_id                    = module.networking.vpc_id
#   public_subnets            = module.networking.public_subnet_ids
#   private_subnets           = module.networking.private_subnet_ids
#   private_subnet_cidr_block = module.networking.private_subnets_cidr_blocks
#   iam_role_arn_lambda_app   = module.security.iam_role_arn_lambda_app
#   iam_role_profile_ec2_ssm  = module.security.iam_role_profile_ec2_ssm
#   database_proxy_sg_id      = module.database.aws_rds_proxy_sg.id
#   database_proxy_endpoint   = module.database.aws_rds_proxy.endpoint
#   database_username         = var.database_username
#   database_password         = var.database_password
#   lambda_module_bucket_name = module.storage.bucket_name
#   lambda_module_bucket_key  = module.storage.lambda_module_key
#   lambda_module_version_id  = module.storage.lambda_module_version_id
# }

# terraform import aws_glue_crawler.MyJob MyJob
