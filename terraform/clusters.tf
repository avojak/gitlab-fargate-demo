resource "aws_ecs_cluster" "gitlab" {
  name = "gitlab-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "fargate" {
  cluster_name       = resource.aws_ecs_cluster.gitlab.name
  capacity_providers = ["FARGATE"]
  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}