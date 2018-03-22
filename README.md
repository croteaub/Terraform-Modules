AWS Config Terraform module
========================

Terraform module which creates AWS Config resources on AWS.  This module will
1. Create a Role for AWS Config to use
2. Turn on AWS Config and configure it to send logs to appropriate SNS Topics and Config Buckets

These types of resources are supported:

* [AWS Config Configuration Recorder](https://www.terraform.io/docs/providers/aws/r/config_configuration_recorder.html)
* [AWS IAM Role](https://www.terraform.io/docs/providers/aws/r/iam_role.html)
* [AWS Config Delivery Channel](https://www.terraform.io/docs/providers/aws/r/config_delivery_channel.html)
* [Aws Config Configuration Recorder Status](https://www.terraform.io/docs/providers/aws/r/config_configuration_recorder_status.html)

Usage
-----

```hcl
module "config" {
  source                          = "git::https://git_username:personalaccesstoken@github.pwc.com/PWC-Terraform-Modules/terraform-aws-config.git"
  all_supported_bool              = "true"
  region                          = "us-east-1"
  is_config_enabled_bool          = "true"
  stamp_letter_id                 = "d"
  account_type_letter_id          = "d"
}
```


Notes
-----

1. A variables file should be created in the same directory in which the preceding main.tf file is included in.  The security_s3_bucket, security_sns_config_topic_arn, region_code are all map variables, which key off the "region" in order to populate the value.  For Up to date variable information visit:

Authors
-------

Currently maintained by [Chris Leibl](https://github.pwc.com/christopher-leibl)  
Module managed by [Chris Leibl](https://github.pwc.com/christopher-leibl).

License
-------

Apache 2 Licensed. See LICENSE for full details.
