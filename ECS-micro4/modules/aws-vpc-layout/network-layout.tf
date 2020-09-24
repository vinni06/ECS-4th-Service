######## availability zones list

data "aws_availability_zones" "available" {}

#######  vpc creation

resource "aws_vpc" "main" {
    cidr_block = var.cidr 
    tags = {
        Name = "Container-VPC"
    }
}

####### Subnets creation



resource "aws_subnet" "dmz" {
	count 			= var.az_count
	cidr_block		= cidrsubnet(aws_vpc.main.cidr_block, 9, count.index)
	availability_zone	= data.aws_availability_zones.available.names[count.index]
	vpc_id			= aws_vpc.main.id
	tags = {
		Name = "${var.subnets[0]}-${count.index+1}"
		}
	}

resource "aws_subnet" "container-apps" {
	count 			= var.az_count
	cidr_block		= cidrsubnet(aws_vpc.main.cidr_block, 9, count.index+10)
	availability_zone	= data.aws_availability_zones.available.names[count.index]
	vpc_id			= aws_vpc.main.id
	tags = {
		Name = "${var.subnets[1]}-${count.index+1}"
		}
	}



######## Internet gateway creation

resource "aws_internet_gateway" "igw" {
	vpc_id			= aws_vpc.main.id
	tags = {	
		Name = "Test-IGateway"
		}
	}


######### Route creation for public trafic through IGW

resource "aws_route" "Test_internet_access" {
	route_table_id		= aws_vpc.main.main_route_table_id
	destination_cidr_block	= "0.0.0.0/0"
	gateway_id		= aws_internet_gateway.igw.id
	}


######### NAT creation with EIP for non-dmz subnets to get internet access

resource "aws_eip" "gwip" {
	count			= var.az_count
	vpc			= true
	depends_on		= [aws_internet_gateway.igw]
	}

resource "aws_nat_gateway" "ngw" {
	count			= var.az_count
	subnet_id		= element(aws_subnet.dmz.*.id, count.index)
	allocation_id		= element(aws_eip.gwip.*.id, count.index)
	}

######## Route table addition for non-dmz subnets, to make it route to NAT for non local trafic

resource "aws_route_table" "nondmz_internet_access" {
	count			= var.az_count
	vpc_id			= aws_vpc.main.id
	route	{
		cidr_block	= "0.0.0.0/0"
		nat_gateway_id  = element(aws_nat_gateway.ngw.*.id, count.index)
		}
	}

######## Associate newly created route tables to the non-dmz subnets


resource "aws_route_table_association" "container-apps" {
	count			= var.az_count
	subnet_id		= element(aws_subnet.container-apps.*.id, count.index)
	route_table_id		= element(aws_route_table.nondmz_internet_access.*.id, count.index)
	}




	
