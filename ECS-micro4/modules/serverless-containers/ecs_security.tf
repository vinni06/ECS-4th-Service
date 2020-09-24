resource "aws_security_group" "elb_sg" {
  #To avoid clashing with base sg, we pass this sg name via a variable
  #name              = "ecs elb sg dev2"
  name 		    = "${var.albsg}"  
  description       = "access control via elb for apps in ecs"
  #vpc_id            = "${aws_vpc.devvpc.id}"
  vpc_id            = "${var.dev-vpc}"
  # As we use https for application access using alb, we need only port 443
  ingress {
      protocol      = "tcp"
      from_port     = "443"
      to_port       = "443"
      cidr_blocks   = ["0.0.0.0/0"]
  }
 
  egress {
      protocol      = "-1"
      from_port     = "0"
      to_port       = "0"
      cidr_blocks   = ["0.0.0.0/0"]
  }
 tags = {
	name = "${var.albsg}"
	}
}
# This SG is for application which can be accessed only via alb 
resource "aws_security_group" "nodeapps_ecs_tasks_sg" {
  #To avoid clashing with base sg, we pass this sg name via a variable
   # name            = "Fargate nodeapps cluster ecs sg dev2"
    name 	    = "${var.fargatesg}"
    description     = "Node apps ecs cluster sg"
    vpc_id          = "${var.dev-vpc}"
    
    ingress {
        protocol    = "tcp"
        from_port   = "${var.app1_port}"
        to_port     = "${var.app1_port}"
        security_groups = ["${aws_security_group.elb_sg.id}"]
    }
    
    ingress {
        protocol    = "tcp"
        from_port   = "${var.app2_port}"
        to_port     = "${var.app2_port}"
        security_groups = ["${aws_security_group.elb_sg.id}"]
    }
    ingress {
        protocol    = "tcp"
        from_port   = "${var.app3_port}"
        to_port     = "${var.app3_port}"
        security_groups = ["${aws_security_group.elb_sg.id}"]
    }
   ingress {
        protocol    = "tcp"
        from_port   = "${var.app4_port}"
        to_port     = "${var.app4_port}"
        security_groups = ["${aws_security_group.elb_sg.id}"]
    }

    
    egress  {
        protocol    = "-1"
        from_port   = "0"
        to_port     = "0"
        cidr_blocks = ["0.0.0.0/0"]
    }
   tags = {
	name = "${var.fargatesg}"
	}
}
