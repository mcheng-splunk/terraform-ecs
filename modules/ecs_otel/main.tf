resource "aws_ecs_task_definition" "otel-collector" {
  family                = "splunk-otel-collector"
  container_definitions = file("${path.module}/otel_collector.json")
  volume { 
    name = "hostfs"
    host_path  = "/"
  }
  network_mode         = "bridge"
}


resource "aws_ecs_service" "main" {
  name            = "splunk-otel-collector-gw-mode"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.otel-collector.arn
  launch_type     = "EC2"
  scheduling_strategy = "DAEMON"

  load_balancer {
    target_group_arn = var.aws_alb_target_group_arn
    // the container_name values comes from our otel_collector.json name field
    container_name   = "splunk-otel-collector"
    container_port   = "9080"
  }

  depends_on = [

  ]

}
