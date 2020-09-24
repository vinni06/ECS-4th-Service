####### Output of VPC, pub and pri subnets ids ########

output "vpid" {
	value = "${aws_vpc.main.id}"
	}

output "dmz-subnetids" {
	value = "${aws_subnet.dmz.*.id}"
	}

output "dmz-subnets-cidr" {
	value = "${aws_subnet.dmz.*.cidr_block}"
	}

output "container-apps-subnetids" {
	value = "${aws_subnet.container-apps.*.id}"
	}

output "container-apps-subnets-cidr" {
	value = "${aws_subnet.container-apps.*.cidr_block}"
	}