variable "cidr" {
	default = "10.44.0.0/16"
	}

variable "az_count" {
	default = "2"
	}

variable "vpcname" {
	default = "Container-VPC"
	}

variable "subnets" {
	type = list
	default = ["Dmz", "Container-apps" ]
	}
