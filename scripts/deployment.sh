#!/bin/bash -ex

action=${1}

# Functions 
deploy() {
    # run terraform init
    terraform init

    # run terraform plan and save it
    terraform plan 

    # run terraform apply with auto-approve
    terraform apply --auto-approve
}

destroy() {
    # run terraform init
    terraform init

    # run terraform plan and save it
    terraform plan -destroy
    # run terraform apply with auto-approve
    # terraform destroy --auto-approve
}

case $action in
  deploy)
    echo "Starting Deployment"
    # Insert commands to start the service
    deploy
    ;;
  destroy)
    echo "Stopping and destroying the service..."
    # Insert commands to stop and destroy the service
    destroy
    ;;
  *)
    # Usage
    echo "Usage: $0 {deploy|destroy}"
    exit 1
    ;;
esac

