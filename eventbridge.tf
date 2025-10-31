resource "aws_cloudwatch_event_rule" "s3_object_created" {
  name        = "${local.name}-s3-object-created-rule"
  description = "EventBridge rule to trigger ECS task on S3 object creation"

  event_pattern = jsonencode({
    "source" : ["aws.s3"],
    "detail-type" : ["Object Created"],
    "detail" : {
      "bucket" : {
        "name" : [aws_s3_bucket.bucket.bucket]
      }
    }
  })

  tags = local.tags
}
