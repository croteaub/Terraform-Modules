variable "security_s3_bucket" {
  type = "map"
  description = "The Name of the Regional Security Bucket in which to store config logs"
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
}

variable "is_config_enabled_bool" {
  description = "Turn on/off AWS Config"
  default     = "true"
}

variable "stamp_letter_id" {
  description = "The Stamp Letter (P=Prod D=Dev S=Stage) in which the resources are in.  Used for naming convention"
}

variable "region_code" {
  description = "The Region code in which corresponds to the current region.  Example UE1 = us-east-1.  Used for naming convnetion"
  type = "map"
}

variable "account_type_letter_id" {
  description = "The Account type Letter ID which describes the account.  Example M=Master N=NonProd P=Prod I=IT S=Security"
}
