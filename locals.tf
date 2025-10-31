locals {
  region = "us-east-1"
  name   = "ecs-tasks-invoked-by-event-bridge"

  vpc_cidr = "10.0.0.0/16"
  azs      = ["us-east-1a", "us-east-1b", "us-east-1c"]

  tags = {
    Project   = "ecs-tasks-invoked-by-event-bridge"
    Terraform = true
  }
}