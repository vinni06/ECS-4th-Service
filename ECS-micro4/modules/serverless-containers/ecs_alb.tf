resource "aws_alb" "ecs_alb" {
    name                = "${var.albname}"
 #   subnets             = ["${aws_subnet.dev_public.*.id}"]
  ##  subnets		= ["${var.pub-subnets}"]
    subnets		= "${var.pub-subnets}"
    security_groups     = ["${aws_security_group.elb_sg.id}"]
}
## Common target groups
resource "aws_alb_target_group" "napps" {
    count           = "${var.no_of_services}"
    name            = "private-node-app${count.index+1}-tg"
    port            = "${count.index+3020}"
    protocol        = "${var.alb_access_protocal}"
    #vpc_id          = "${aws_vpc.devvpc.id}"
    vpc_id          = "${var.dev-vpc}"
    target_type     = "ip"
  
    health_check    {
        healthy_threshold    = "3"
        interval            = "30"
        protocol            = "${var.alb_access_protocal}"
        matcher             = "200"
        timeout             = "3"
        path                = "${var.app_health_check_path}"
        unhealthy_threshold = "2"
    }
}

resource "aws_alb_listener" "appfrontend" {
    load_balancer_arn   = "${aws_alb.ecs_alb.id}"
    port                = "443"
    protocol            = "HTTPS"
    ssl_policy          = "ELBSecurityPolicy-2016-08"
#    certificate_arn     = "arn:aws:iam::052578464564:server-certificate/randomkops.ga"
#    certificate_arn	= "arn:aws:acm:ap-southeast-1:052578464564:certificate/70b6b4ea-3274-41cf-b0a1-814257f939c2"  
    certificate_arn    ="arn:aws:iam::052578464564:server-certificate/randomkops.gaa"
    default_action { 
        target_group_arn    = "${element(aws_alb_target_group.napps.*.arn,0)}"
        type                = "forward"   
    }
}
resource "aws_alb_listener_rule" "app2listener" {
        listener_arn            = "${aws_alb_listener.appfrontend.arn}"
        action  {
            type                = "forward"
            target_group_arn    = "${element(aws_alb_target_group.napps.*.arn,1)}"
        }
        condition {
            path_pattern {
            values      = ["${var.app2paths}"]
        }
   }
}
resource "aws_alb_listener_rule" "app3listener" {
	count			= "${length(var.app3paths)}"
        listener_arn            = "${aws_alb_listener.appfrontend.arn}"
        action  {
            type                = "forward"
            target_group_arn    = "${element(aws_alb_target_group.napps.*.arn,2)}"
        }
        condition {
            path_pattern {
            values      = ["${var.app3paths[count.index]}"]
        }
    }
}
resource "aws_alb_listener_rule" "app4listener" {
        listener_arn            = "${aws_alb_listener.appfrontend.arn}"
        action  {
            type                = "forward"
            target_group_arn    = "${element(aws_alb_target_group.napps.*.arn,3)}"
        }
        condition {
            path_pattern {
            values      = ["${var.app4paths}"]
        }
    }
}


output "alb_url_name" {
  value = "${aws_alb.ecs_alb.dns_name}"
}

