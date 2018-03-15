// Create AWS Config Recording
resource "aws_config_configuration_recorder" "aws_config_recorder" {
  name     = "${upper("PA-CFG-${var.stamp_letter_id}-${lookup(var.region_code, var.region)}-${var.account_type_letter_id}-CFG-RCDR")}"
  role_arn = "${aws_iam_role.aws_config_role.arn}"
  recording_group {
    all_supported = "${var.all_supported_bool}"
  }
}

// Create Role for AWS Config to Use
resource "aws_iam_role" "aws_config_role" {
  name = "${upper("PA-ROL-${var.stamp_letter_id}-IS-S-CFG-CONFIG")}"
  description = "PwC Role for AWS Config"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

// Attach AWS Managed Config Policy
resource "aws_iam_role_policy_attachment" "aws_config_role_policy_attachment" {
  role       = "${aws_iam_role.aws_config_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}

// Create Delivery Channels for AWS config
resource "aws_config_delivery_channel" "aws_config_delivery_channel" {
  depends_on     = ["aws_config_configuration_recorder.aws_config_recorder"]
  name           = "aws_config_delivery_channel"
  s3_bucket_name = "${lookup(var.security_s3_bucket, var.region)}"
  sns_topic_arn  = "${lookup(var.security_sns_config_topic_arn, var.region)}"
  s3_key_prefix  = "config"
}

// Turn on AWS config

resource "aws_config_configuration_recorder_status" "aws_config_recorder_status" {
  depends_on = ["aws_config_delivery_channel.aws_config_delivery_channel"]
  name       = "${aws_config_configuration_recorder.aws_config_recorder.name}"
  is_enabled = "${var.is_config_enabled_bool}"
}
