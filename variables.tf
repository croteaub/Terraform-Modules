variable "security_s3_bucket" {
  type = "map"
  description = "The S3 Bucket to put the CloudTrail Logs.  This should be a 'map' variable and will adjust on a per region and per stamp basis"
  default = {
    "us-east-1" =  "pa-as3-p-ue1-s-buc-p-sec-001"
    "us-east-2" =  "pa-as3-p-ue2-s-buc-p-sec-001"
    "us-west-1" =  "pa-as3-p-uw1-s-buc-p-sec-001"
    "us-west-2" =  "pa-as3-p-uw2-s-buc-p-sec-001"
  }
}

variable "all_supported_bool" {
  description = "Boolean Variable for all supported types in AWS config"
  default     = "true"
}

variable "region" {
  description = "The region to launch AWS-Config"
}

variable "security_sns_config_topic_arn" {
  description = "The Security SNS Topic in which to send Config Notification too"
  type = "map"
  default = {
    "us-east-1" =  "arn:aws:sns:us-east-1:583716045488:PA-SNS-P-UE1-S-TPC-P-CONFG-001"
    "us-east-2" =  "arn:aws:sns:us-east-2:583716045488:PA-SNS-P-UE2-S-TPC-P-CONFG-001"
    "us-west-1" =  "arn:aws:sns:us-west-1:583716045488:PA-SNS-P-UW1-S-TPC-P-CONFG-001"
    "us-west-2" =  "arn:aws:sns:us-west-2:583716045488:PA-SNS-P-UW2-S-TPC-P-CONFG-001"
  }
}

variable "cloudtrail_logs_group_arn" {
  description = "The ARN of the cloudtrail logs group.  Used in the Config Rule for Cloudtrail Logs"
  type = "map"
  default = {
    "us-east-1" =  "arn:aws:logs:us-east-1:583716045488:log-group:PA-CLG-P-UE1-S-CLTL-001"
    "us-east-2" =  "arn:aws:logs:us-east-2:583716045488:log-group:PA-CLG-P-UE2-S-CLTL-001"
    "us-west-1" =  "arn:aws:logs:us-west-1:583716045488:log-group:PA-CLG-P-UW1-S-CLTL-001"
    "us-west-2" =  "arn:aws:logs:us-west-2:583716045488:log-group:PA-CLG-P-UW2-S-CLTL-001"
  }
}

variable "is_config_enabled_bool" {
  description = "Turn on/off AWS Config"
  default     = "true"
}

variable "stamp_letter_id" {
  description = "The Stamp Letter (P=Prod D=Dev S=Stage) in which the resources are in.  Used for naming convention"
}

variable "region_code" {
  type = "map"
  description = "The 3 Letter code which corresponds to the region being provisioned into example: ue1=us-east-1"
  default = {
    "us-east-1" = "ue1"
    "us-east-2" = "ue2"
    "us-west-1" = "uw1"
    "us-west-2" = "uw2"
  }
}

variable "account_type_letter_id" {
  description = "The Account type Letter ID which describes the account.  Example M=Master N=NonProd P=Prod I=IT S=Security"
}
