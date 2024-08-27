pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/iammrdm/jenkins-setup.git'
                sh 'ls -laht'
            }
        }

        stage('Deploy VPC') {
            steps {
                // Add your build steps here
                echo 'Checking Terraform version and install if necessary'
                sh 'cd assestment-infra/vpc; bash ../../scripts/tfcheck.sh'
            }
        }

        stage('Create Security Groups') {
            steps {
                // Add your build steps here
                echo 'Checking Terraform version and install if necessary'
            }
        }

        stage('Deploy EC2 Instance') {
            steps {
                // Add your build steps here
                echo 'Checking Terraform version and install if necessary'
            }
        }

        stage('Create S3 Bucket') {
            steps {
                // Add your build steps here
                echo 'Checking Terraform version and install if necessary'
            }
        }

        stage('Deploy ALB') {
            steps {
                // Add your build steps here
                echo 'Checking Terraform version and install if necessary'
            }
        }
    }

    post {
        always {
            echo 'Performing cleanup...'
            cleanWs()  // Clean up the workspace
        }
        success {
            echo 'Pipeline succeeded.'
        }
        failure {
            echo 'Pipeline failed.'
        }
        unstable {
            echo 'Pipeline is unstable.'
        }
        changed {
            echo 'Pipeline result has changed.'
        }
    }
}
