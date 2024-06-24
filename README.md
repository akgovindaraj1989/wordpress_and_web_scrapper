# WORDPRESS on AWS Using Terraform and python code for webscraping
## Part 1: Terraform code for 3-Tier Multi-AZ wordpress appliction installation and Insfrastruction provision.
### 3-Tier Multi-AZ WordPress Application using Infrastrucure as Code (IAC)
### **Infrastructure details as below:**
1) Network Infrastructure
- A single VPC (vpc.tf) and Internet Gateway (IGW) (internetgateway.tf)
- Two availability zones (AZs) (Defined in variable.tf)
- A private application subnet, a private database subnet and a public subnet in each AZ (subnets.tf)
- Three route tables - one public which accepts traffic from and Internet Gateway, two private which accept incoming traffic from two Nat Gateways (natgateway.tf) (hosted in the public subnet of each AZ) (routeTable.tf)
2) Application Insfrastructure
- Security group rules for all resources (securitygroups.tf)
- AWS Relational Database Service (RDS) resource (rdsdb.tf)
- AWS Secrets Manager (secrets.tf)
- Launch configuration (ec2.tf)
-  load balancer (alb.tf), listener , asuto scaling group (asg.tf)

#### Installation Process

- I have already created AWS Profile free tier with Access and secret Access key.
- I have installed following software in my laptop: Terraform, AWS CLI, git.
Before installing, I have created s3 bucket with versioning enabled in order to store the Terraform state remotely and dynamodb table with the same name I have added backend.tf


```
git clone https://github.com/akgovindaraj1989/wordpress_and_web_scrapper.git
```
- Once git cloned successfully please edit the **backend.tf** with created s3 bucket name and do othe same same for dynamodb table for lock as below:
```
   terraform {
  backend "s3" {
    bucket         = "<your-bucket-name>"
    key            = "terraform.tfstate"
    region         = "eu-west-2"  
    encrypt        = true
    dynamodb_table = "<your-dynamodb-lock-table-name>"  
  }
```
- If you you want different region please feel free to change the region in **backend.tf** please change the availability zone details in **variable.tf**.
-  please save the file and go to command line or powershell run the below command:
```
terraform init
terraform plan
terraform apply
```
## Part 1: Listing top 20 articles using python code (webscraping)
- Please install latest version of python and ensure the internet connectivity where you are going to run the python code.
  ```
  python code.py
  ```
