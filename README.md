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
  source                          = "git::https://git_username:personalaccesstoken@github.pwc.com/PWC-Terraform-Modules/terrafrom-aws-config.git"
  security_s3_bucket              = "${var.security_s3_bucket}"
  all_supported_bool              = "${var.all_support}"
  region                          = "${var.region}"
  security_sns_config_topic_arn   = "${var.security_sns_config_topic_arn}"
  is_config_enabled_bool          = "${var.is_config_enabled_bool}"
  stamp_letter_id                 = "${var.stamp_letter_id}"
  account_type_letter_id          = "${var.account_type_letter_id}"
  region_code                     = "${var.region_code}"
  }
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
