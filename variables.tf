variable "security_s3_bucket" {
  type = "map"
}

variable "all_supported_bool" {
  description = "Boolean Variable for all supported types in AWS config"
  default     = "true"
}

variable "region" {
  description = "The region to launch AWS-Config"
}

variable "security_sns_config_topic_arn" {
  type = "map"
  default = {
    "us-east-1" =  "arn:aws:sns:us-east-1:638514094130:PA-SNS-ConfigTopic-d-ue1-001"
    "us-east-2" =  "arn:aws:sns:us-east-2:638514094130:PA-SNS-ConfigTopic-d-ue2-001"
    "us-west-1" =  "arn:aws:sns:us-west-1:638514094130:PA-SNS-ConfigTopic-d-uw1-001"
    "us-west-2" =  "arn:aws:sns:us-west-2:638514094130:PA-SNS-ConfigTopic-d-uw2-001"
  }
}

variable "is_config_enabled_bool" {
  description = "Turn on/off AWS Config"
  default     = "true"
}

variable "stamp_letter_id" {}

variable "region_code" {
  type = "map"
  default = {
    "us-east-1" = "ue1"
    "us-east-2" = "ue2"
    "us-west-1" = "uw1"
    "us-west-2" = "uw2"
  }
}

variable "account_type_letter_id" {}
