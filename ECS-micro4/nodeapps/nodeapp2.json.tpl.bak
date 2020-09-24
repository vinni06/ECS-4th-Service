    
[
  {
    "name": "${appname}",
    "image": "${app_image}",
    "cpu": ${fargate_cpu},
    "memory": ${fargate_memory},
    "networkMode": "awsvpc",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${loggroupname}",
          "awslogs-region": "${aws_region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      }
    ],
    "secrets": [
        {
          "valueFrom": "${pmsvalue1}",
          "name": "${keyname1}"
        },
        {
          "valueFrom": "${pmsvalue2}",
          "name": "${keyname2}"
        }
      ]
  }
]