# Following commands used to build and upload images to ECR
````
1. aws ecr get-login --profile=accel --region=ap-southeast-1 

2. docker login -u AWS -p <token> https://<aws_acc_no>.dkr.ecr.ap-southeast-1.amazonaws.com

3. $ cd /ecs-node-apps/ecs_nodejs_ssl_app1   
   $ ls
     Dockerfile  certs  package.json  server.js
     docker build -t nodeapp1:latest . 
   $ docker tag nodeapp1:latest <aws_acc_no>.dkr.ecr.ap-southeast-1.amazonaws.com/nodeapp1:latest
   $ docker push <aws_acc_no>.dkr.ecr.ap-southeast-1.amazonaws.com/nodeapp1:latest

Similarly for remaining to nodeapps as well.
````

