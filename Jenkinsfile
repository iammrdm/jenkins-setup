pipeline {
    agent {
        // Replace this with your agent
        label 'local' 
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    try {
                        // Clone the specified Git repository branch ('main') into the workspace
                        checkout([
                            $class: 'GitSCM', branches: [[name: '*/main']], // Update */main to your specific branch to be use
                            doGenerateSubmoduleConfigurations: false, 
                            extensions: [], 
                            submoduleCfg: [], 
                            userRemoteConfigs: [[url: 'https://github.com/iammrdm/jenkins-setup.git']], // Replace with your repository URL
                        ])
                    } catch (Exception e) {
                        // If cloning fails, the pipeline will stop with an error message
                        error "Failed to clone repository: ${e.message}"
                    }
                }
            }
        }

        stage('Configure AWS') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: '8f96ea23-bd31-4799-b033-9833a3ed72ba' // Replace with your AWS credentials ID that is setup on Jenkins CI/CD
                ]]) {
                    script {
                        try {
                            echo "Configuring AWS CLI"
                            
                            // Configure AWS CLI with the provided credentials and region
                            sh '''
                                aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
                                aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
                                aws configure set default.region ap-southeast-1
                            '''
                            
                            // Verify AWS configuration by retrieving caller identity
                            sh 'aws sts get-caller-identity'
                        } catch (Exception e) {
                            // If AWS configuration fails, the pipeline will stop with an error message
                            error "Failed to configure AWS: ${e.message}"
                        }
                    }
                }
            }
        }

        stage('Configure and Setup Terraform') {
            steps {
                script {
                    try {
                        echo "Configuring terraform with required version"
                        
                        // Run the script(tfcheck.sh) to check and configure the required Terraform version
                        sh 'cd assestment-infra-modular && bash ../scripts/tfcheck.sh'
                    } catch (Exception e) {
                        // If Terraform configuration fails, the pipeline will stop with an error message
                        error "Failed to configure Terraform: ${e.message}"
                    }
                }
            }
        }

        stage('Deploy') {
            when {
                expression { 
                    return !env.CLEANUP.toBoolean() // Only run this stage if CLEANUP is not set to true
                }
            }
            steps {
                script {
                    try {
                        // Execute the deployment script to deploy the infrastructure, this will run the terraform commands such as terraform init, terrform plan and terraform apply --auto-approve
                        sh 'cd assestment-infra-modular && bash ../scripts/deployment.sh deploy'
                    } catch (Exception e) {
                        // If deployment fails, the pipeline will stop with an error message
                        error "Deployment failed: ${e.message}"
                    }
                }
            }
        }

        stage('Destroy Service') {
            when {
                expression { 
                    return env.CLEANUP.toBoolean() // Only run this stage if CLEANUP is set to true
                }
            }
            steps {
                script {
                    try {
                        // Execute the deployment script to destroy the infrastructure, this will run the terraform commands such as terraform init, terrform plan -destory and terraform destroy --auto-approve
                        sh 'cd assestment-infra-modular && bash ../scripts/deployment.sh destroy'
                    } catch (Exception e) {
                        // If destruction fails, the pipeline will stop with an error message
                        error "Service destruction failed: ${e.message}"
                    }
                }
            }
        }
    }

    post {
        always {
            // Always perform cleanup of workspace after pipeline execution, regardless of success or failure, to save space on the disk
            echo 'Performing cleanup...'
            cleanWs()  // Clean up the workspace
        }
        success {
            // If the deployment succeeds, log success message (can add notifications here)
            echo 'Pipeline succeeded.' 
        }
        failure {
            // If the deployment fails, log failure message (can add notifications here)
            echo 'Pipeline failed.' 
        }
    }
}
