#!/bin/bash

# Function to install Terraform using tfenv
install_terraform() {
    required_version=$(grep -oP 'required_version\s*=\s*"\K[^"]+' providers.tf)

    if [ -z "$required_version" ]; then
        echo "Terraform required_version not found in providers.tf. Please specify the version."
        exit 1
    fi

    # Check if tfenv is installed
    if ! command -v tfenv &> /dev/null; then
        echo "tfenv is not installed. Installing tfenv..."
        git clone https://github.com/tfutils/tfenv.git ~/.tfenv
        echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile
        export PATH="$HOME/.tfenv/bin:$PATH"
        source ~/.bash_profile
    fi

    echo "Installing Terraform $required_version..."
    tfenv install $required_version
    tfenv use $required_version
}

# Check if Terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "Terraform is not installed. Attempting to install the required version..."
    install_terraform
fi

# Ensure Terraform is using the correct version
required_version=$(grep -oP 'required_version\s*=\s*"\K[^"]+' providers.tf)
current_version=$(terraform version -json | jq -r '.terraform_version')

if [ "$required_version" != "$current_version" ]; then
    echo "Terraform version mismatch. Installing the required version..."
    install_terraform
fi

# Run terraform fmt -check to see if formatting is needed
echo "Checking Terraform format..."
if terraform fmt -check -recursive; then
    echo "All Terraform files are properly formatted."
else
    echo "Some Terraform files need formatting. Running terraform fmt..."
    terraform fmt -recursive

    if [ $? -eq 0 ]; then
        echo "Terraform files have been formatted successfully."
    else
        echo "An error occurred while formatting Terraform files."
        exit 1
    fi
fi
