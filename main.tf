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

// Managed Config Rule for S3-Public-Read-Prohibited
resource "aws_config_config_rule" "S3-Public-Read-Prohibited" {
  name = "S3-Public-Read-Prohibited"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  }

  depends_on = ["aws_config_configuration_recorder.aws_config_recorder"]
}

// Managed Config Rule for S3-Public-Write-Prohibited
resource "aws_config_config_rule" "S3-Public-Write-Prohibited" {
  name = "S3-Public-Write-Prohibited"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
  }

  depends_on = ["aws_config_configuration_recorder.aws_config_recorder"]
}

// Managed Config Rule for RDS Storage Encryption

resource "aws_config_config_rule" "RDS-Storage-Encrypted" {
  name = "RDS-Storage-Encrypted"

  source {
    owner             = "AWS"
    source_identifier = "RDS_STORAGE_ENCRYPTED"
  }

  depends_on = ["aws_config_configuration_recorder.aws_config_recorder"]
}

// Creates Managed Config Rule to Check if CloudTrail is enabled and it is logging back to to the correct bucket and log group

resource "aws_config_config_rule" "cloudtrail-enabled" {
  name = "Cloudtrail-Enabled"

  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_ENABLED"
  }
  input_parameters = "{\"s3BucketName\":\"pa-as3-d-ue1-s-buc-p-sec-001\",\"cloudWatchLogsLogGroupArn\":\"arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:PA-CLG-D-UE1-S-CLTL-001:*\"}"
  depends_on = ["aws_config_configuration_recorder.aws_config_recorder"]
}

resource "aws_config_config_rule" "encrypted-volumes" {
  name = "Encrypted-Volumes"

  source {
    owner             = "AWS"
    source_identifier = "ENCRYPTED_VOLUMES"
  }

  depends_on = ["aws_config_configuration_recorder.aws_config_recorder"]
}

resource "aws_config_config_rule" "iam-password-policy" {
  name = "IAM-Password-Policy"

  source {
    owner             = "AWS"
    source_identifier = "IAM_PASSWORD_POLICY"
  }
  input_parameters = "{\"RequireUppercaseCharacters\":\"true\",\"RequireLowercaseCharacters\":\"true\",\"RequireSymbols\":\"true\",\"RequireNumbers\":\"true\",\"MinimumPasswordLength\":\"8\",\"PasswordReusePrevention\":\"8\",\"MaxPasswordAge\":\"90\"}"
  depends_on = ["aws_config_configuration_recorder.aws_config_recorder"]
}
