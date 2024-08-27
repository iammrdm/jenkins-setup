# Simple Infrastructure Setup
## This repository contains scripts and configurations to set up a simple infrastructure for Jenkins, including the creation of a Virtual Private Cloud (VPC), deployment of an EC2 instance, Application Load Balancer (ALB), and an S3 bucket on AWS.

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

### Prerequisites
- AWS Access Key configured with the appropriate permissions on local
- Terraform installed on your local machine
- Jenkins installed on the EC2 instance or local required for ci/cd

### How to use?