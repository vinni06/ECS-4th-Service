provider "aws" {
    shared_credentials_file = "$Home/.aws/credentials"
    profile ="accel"
    region = "ap-southeast-1"
}

module "aws-vpc-layout" {
    source = "./modules/aws-vpc-layout"
    #app = "demo"
    #env = "prod"

}
module "ecs_cluster"{
    source = "./modules/serverless-containers"
    dev-vpc = "${module.aws-vpc-layout.vpid}"
   pub-subnets = "${module.aws-vpc-layout.dmz-subnetids}"
   pri-subnets = "${module.aws-vpc-layout.container-apps-subnetids}"
}