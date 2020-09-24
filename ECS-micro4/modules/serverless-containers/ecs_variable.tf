variable "clustername" {
	default = "serverless-node-apps"
	}
variable "albname" {
	default = "ms-njapps-private"
	}
variable "appname" {
	description  = "tdn and service name"
	default = "njappft"
	}
variable "albsg" {
	default = " private ecs alb sg"
	}
variable  "fargatesg" {
	default = "fargate private sg"
	}
variable "app1_port" {
  default = "3020"
}
variable "app2_port" {
  default = "3021"
}
variable "app3_port" {
  default = "3022"
}
variable "app4_port" {
default = "3023"
}

variable "app_task_count" {
  default = "2"
}
variable "ecs_task_execution_role" {
  default = "arn:aws:iam::052578464564:role/ecsTaskExecutionRoles"
}
variable "app_health_check_path" {
  default = "/"
}
variable "fargate_cpu" {
  default = "256"
}
variable "fargate_memory" {
  default = "512"
}
variable "alb_access_protocal" {
  default   = "HTTPS"
}
variable "loggroupname" {
    default = "ecs_napps_loggroup"
}
variable "pmsvalue1" {
  default = "akey"
}
variable "pmsvalue2" {
  default = "arn:aws:ssm:ap-southeast-1:052578464564:parameter/skey"
}

 variable "accesskey" {
  default = "acckey"
}
 variable "secretkey" {
  default = "seckey"
}

variable "no_of_services" {
  default = "4"
}
variable "dnsnjappalb" {
  default = "randomkops.ga"
}

variable "pub-subnets" {
	type = list(string)
	#default = ["subnet-0391b227394912bcf","subnet-021de1215154f0dc4"]
	}
variable "pri-subnets" {
	type = list(string)
	#default = ["subnet-0d336b7d6b49be2e0", "subnet-080b9b989e468ff4a"]
	}
variable "dev-vpc" {
	default = "string" 
	#default = "vpc-088eb15d4d3335209"
	}
variable "awspregion" {
    default = "ap-southeast-1"
}
variable "app2paths" {
	default = "/app2/*"
	}
variable "app3paths" {
	type = list
	default = ["/apple/contacts/*", "/apple/accounts/*", "/apple/leads/"]
	}
variable "app4paths" {
default = "/app4/*"
}

