pipeline {
    agent {
        label 'local' // Replace with your default agent label
    }

    stages {
       stage('Clone Repository') {
            steps {
                // Checkout code from the repository
                 checkout([
                    $class: 'GitSCM', branches: [[name: '*/main']], 
                        doGenerateSubmoduleConfigurations: false, 
                        extensions: [], 
                        submoduleCfg: [], 
                    userRemoteConfigs: [[url: 'https://github.com/iammrdm/jenkins-setup.git']], // Replace with your repository URL
                ])
            }
        }


        stage('Configure AWS') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: '8f96ea23-bd31-4799-b033-9833a3ed72ba' // Replace with your AWS credentials ID
                ]]) {
                    script {
                        echo "Configuring AWS CLI"
                        
                        //  AWS CLI with the credentials and region
                        sh '''
                            aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
                            aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
                            aws configure set default.region ap-southeast-1
                        '''
                        
                        //  AWS CLI command to verify configuration
                        sh 'aws sts get-caller-identity'
                    }
                }
            }
        }

        stage('Configure and setup Terraform') {
            steps {
                script {
                    echo "Configuring terraform with required version"
                    sh 'cd assestment-infra-modular && bash ../scripts/tfcheck.sh'
                }
            }
        }

        stage('Deploy') { // Deployment
            steps {
                script {
                    sh 'bash scripts/deployment.sh deploy'
                }
            }
        }
// Conditional stage based on the boolean parameter
        stage('Destroy Service') {
            when {
                expression {
                    return params.CLEANUP
                }
            }
            steps {

                sh 'bash scripts/deployment.sh destroy'
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
