# Simple Infrastructure Setup
## This repository contains scripts and configurations to set up a simple infrastructure, It will create a Virtual Private Cloud (VPC), deployment of an EC2 instance, Application Load Balancer (ALB), and an S3 bucket on AWS.

---
# Directory Structure
.
├── Jenkinsfile
├── README.md
├── assestment-infra-modular
│   ├── data-sources.tf
│   ├── main.tf
│   ├── modules
│   │   ├── alb
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── ec2
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── s3_bucket
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   └── vpc
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── variables.tf
│   ├── outputs.tf
│   └── providers.tf
└── scripts
    └── tfcheck.sh
    └── deployment.sh

### Prerequisites
- AWS CLI on local or on Jenkins agent
- AWS Access Key configured with the appropriate permissions
- Terraform installed on your local machine or on Jenkins Agent
- Jenkins installed on the EC2 instance or local required for ci/cd

### How to use?

- Clone this repository: 
`git clone https://github.com/iammrdm/jenkins-setup.git` 

- You have 2 options:
    - Run Directly on the folder:
        - Go to the folder `cd assestment-infra-modular`
        - Run the script to check tf version and installed the required version: `bash ../scripts/tfcheck.sh`
        - Initialize the terraform: `terraform init`
        - Plan the terraform and save it: `terraform plan -out tfplan.out`
        - Apply the terraform: `terraform apply tfplan.out --auto-approve`
        - To destroy the services after testing: `terraform destroy tfplan.out --auto-approve`
    - Run the deployment script inside the folder:
        - Go to the folder `cd assestment-infra-modular`
        - Run the script to check tf version and installed the required version: `bash ../scripts/tfcheck.sh`
        - Run the deployment script to deploy the services `bash ../scripts/deployment.sh deploy`
        - Run the deployment script to destroy the services after testing:  `bash ../scripts/deployment.sh destroy`

### Definition
- assestment-infra-modular: Contains the terraform files
- assestment-infra-modular/modules: Contains the modules(VPC, EC2, ALB, S3) used on this project
- Jenkinsfile: The pipeline script
- scripts: Contains the scripts used on this project
    - tfcheck.sh: this will check the terraform if it is installed or not, and will check the terraform required version on the providers.tf and use it as a default version.
    - deployment.sh: this will deploy services and/or destroy the services after testing. `Usage: ./scripts/deployment.sh {deploy|destroy}`