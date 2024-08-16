pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo "stage 1"
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo "stage 2"
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo "stage 3"
                sh 'node --version'
                echo 'Deploying....'
            }
        } 
    }
    post{
        success {
            echo 'This will run only if successful'
        }
        failure {
            echo 'This will run only if failed'
        }
    }
}


#example 1

pipeline {
    agent any
    environment {
        AWS_CREDENTIALS_ID = 'aws-credentials-id'  // Jenkins credentials ID for AWS
        EKS_CLUSTER_NAME = 'my-eks-cluster'        // Name of your EKS cluster
        TERRAFORM_DIR = 'terraform'                // Directory containing Terraform configuration
        KUBE_NAMESPACE = 'default'                 // Namespace where you want to deploy pods
    }
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                dir("${TERRAFORM_DIR}") {
                    withCredentials([aws(credentialsId: "${AWS_CREDENTIALS_ID}", region: 'us-west-2')]) {
                        sh 'terraform init'
                    }
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                dir("${TERRAFORM_DIR}") {
                    withCredentials([aws(credentialsId: "${AWS_CREDENTIALS_ID}", region: 'us-west-2')]) {
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
        stage('Configure kubectl') {
            steps {
                withCredentials([aws(credentialsId: "${AWS_CREDENTIALS_ID}", region: 'us-west-2')]) {
                    sh '''
                        # Install AWS CLI if not installed
                        pip install awscli
                        # Get EKS cluster credentials
                        aws eks update-kubeconfig --name ${EKS_CLUSTER_NAME}
                    '''
                }
            }
        }
        stage('Conditional Deployments') {
            steps {
                script {
                    def deployments = [
                        'deployment1.yaml',
                        'deployment2.yaml'
                    ]
                    
                    deployments.each { deploymentFile ->
                        if (fileExists("k8s/${deploymentFile}")) {
                            echo "Deploying ${deploymentFile} to EKS"
                            sh """
                                kubectl apply -f k8s/${deploymentFile} -n ${KUBE_NAMESPACE}
                            """
                        } else {
                            echo "File ${deploymentFile} not found. Skipping deployment."
                        }
                    }
                }
            }
        }
    }
    post {
        always {
            // Clean up or perform any necessary final steps
            cleanWs()
        }
    }
}


example 2


pipeline {
    agent any
    environment {
        AWS_CREDENTIALS_ID = 'aws-credentials-id'  // Jenkins credentials ID for AWS
        EKS_CLUSTER_NAME = 'my-eks-cluster'        // Name of your EKS cluster
        TERRAFORM_DIR = 'terraform'                // Directory containing Terraform configuration
        KUBE_NAMESPACE = 'default'                 // Namespace where you want to deploy pods
        DEPLOYMENT_FOLDER = 'k8s'                  // Folder containing Kubernetes deployment files
    }
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                dir("${TERRAFORM_DIR}") {
                    withCredentials([aws(credentialsId: "${AWS_CREDENTIALS_ID}", region: 'us-west-2')]) {
                        sh 'terraform init'
                    }
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                dir("${TERRAFORM_DIR}") {
                    withCredentials([aws(credentialsId: "${AWS_CREDENTIALS_ID}", region: 'us-west-2')]) {
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
        stage('Configure kubectl') {
            steps {
                withCredentials([aws(credentialsId: "${AWS_CREDENTIALS_ID}", region: 'us-west-2')]) {
                    sh '''
                        # Install AWS CLI if not installed
                        pip install awscli
                        # Get EKS cluster credentials
                        aws eks update-kubeconfig --name ${EKS_CLUSTER_NAME}
                    '''
                }
            }
        }
        stage('Conditional Deployments') {
            steps {
                script {
                    // Check if the deployment folder exists
                    if (fileExists("${DEPLOYMENT_FOLDER}")) {
                        echo "Deployment folder ${DEPLOYMENT_FOLDER} found. Proceeding with deployments."

                        def deploymentFiles = sh(script: "ls ${DEPLOYMENT_FOLDER}", returnStdout: true).trim().split('\n')

                        deploymentFiles.each { file ->
                            echo "Deploying ${file} to EKS"
                            sh """
                                kubectl apply -f ${DEPLOYMENT_FOLDER}/${file} -n ${KUBE_NAMESPACE}
                            """
                        }
                    } else {
                        echo "Deployment folder ${DEPLOYMENT_FOLDER} not found. Skipping deployments."
                    }
                }
            }
        }
    }
    post {
        always {
            // Clean up or perform any necessary final steps
            cleanWs()
        }
    }
}