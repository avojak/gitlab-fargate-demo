resource "aws_ecs_task_definition" "test-task" {
  family                   = "test-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions = jsonencode([
    {
      "name": "ci-coordinator",
      "image": "avojak/gitlab-fargate-driver-ubi8:1.0.0",
      "cpu": 1024,
      "memory": 2048,
      "essential": true,
      "portMappings": [
        {
          "containerPort": 22,
          "protocol": "tcp"
        }
      ]
    }
  ])
}