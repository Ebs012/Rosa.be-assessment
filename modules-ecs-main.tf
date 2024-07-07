resource "aws_ecs_cluster" "app_cluster" {
  name = "app-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "httpd:2.4"
      cpu       = 256
      memory    = 512
      essential = true

      command    = ["/bin/sh", "-c", "echo '<html> <head> <title>Amazon ECS Sample App</title> <style>body {margin-top: 40px; background-color: #333;} </style> </head><body> <div style=color:white;text-align:center> <h1>Amazon ECS Sample App</h1> <h2>Congratulations!</h2> <p>Your application is now running on a container in Amazon ECS.</p> </div></body></html>' > /usr/local/apache2/htdocs/index.html && httpd-foreground"]
      entryPoint = []

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      runtimePlatform = {
        operatingSystemFamily = "LINUX"
      }
    }
  ])
}

resource "aws_ecs_service" "app_service" {
  name            = "app-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.app.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = true
    security_groups  = var.security_group_ids
  }

  desired_count = 1

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "app"
    container_port   = 80
  }
}

output "cluster_id" {
  value = aws_ecs_cluster.app_cluster.id
}

output "service_id" {
  value = aws_ecs_service.app_service.id
}
