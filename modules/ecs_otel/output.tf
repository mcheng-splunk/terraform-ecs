output "aws_ecs_task_definition_id" {
    value = aws_ecs_task_definition.otel-collector.arn
}