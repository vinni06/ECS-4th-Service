resource "aws_ecs_cluster" "ms_nodeapps_cluster_dev" {
    name = var.clustername
}

## Container data files for all apps
data "template_file" "nodeapps" {
    count = "${var.no_of_services}"
    template = "${file("nodeapps/nodeapp${count.index+1}.json.tpl")}"

    vars = {
        appname         = "nodeapp${count.index+1}"
        app_image       = "052578464564.dkr.ecr.ap-southeast-1.amazonaws.com/nodeapp${count.index+1}:latest"
        fargate_cpu     = "${var.fargate_cpu}"
        fargate_memory  = "${var.fargate_memory}"
        aws_region      = "${var.awspregion}"
        app_port        = "${count.index+3020}"
        loggroupname    = "${var.loggroupname}"
        pmsvalue1       = "${var.pmsvalue1}"
        pmsvalue2       = "${var.pmsvalue2}"
        keyname1        = "${var.accesskey}"
        keyname2        = "${var.secretkey}"
    }
}

### Task definition files for all apps
resource "aws_ecs_task_definition" "nodeappstdn" {
	count			    = var.no_of_services
        family                      = "${var.appname}-${count.index+1}-task"
        execution_role_arn          = "${var.ecs_task_execution_role}"  
        network_mode                = "awsvpc"
        requires_compatibilities    = ["FARGATE"]    
        cpu                         = "${var.fargate_cpu}"
        memory                      = "${var.fargate_memory}"
        container_definitions       = "${element(data.template_file.nodeapps.*.rendered,count.index)}"
}

##### Services for all apps
resource "aws_ecs_service" "nodeappsservice" {
        count                   = "${var.no_of_services}"
        name                    = "${var.appname}-${count.index+1}-service"
        cluster                 = "${aws_ecs_cluster.ms_nodeapps_cluster_dev.id}"
        task_definition         = "${element(aws_ecs_task_definition.nodeappstdn.*.arn,count.index)}"
        desired_count           = "${var.app_task_count}"
        launch_type             = "FARGATE"
    network_configuration {
        security_groups         = ["${aws_security_group.nodeapps_ecs_tasks_sg.id}"]
       # subnets                 = ["${element(aws_subnet.dev_public.*.id,count.index)}"]
       ## While number of tasks are more than 1, then configure subnet as below
      #   subnets			= ["${aws_subnet.dev_private.*.id}"]
    # To use private or public subnets to run the containers, change here
	#subnets 			= "${var.pub-subnets}"
	subnets 			= "${var.pri-subnets}"
        assign_public_ip        = false
    }
    load_balancer   {
        target_group_arn        = "${element(aws_alb_target_group.napps.*.arn,count.index)}"
        container_name          = "nodeapp${count.index+1}"
        container_port          = "${count.index+3020}"

    }
    depends_on = [aws_alb_listener.appfrontend]
}
