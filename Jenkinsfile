pipeline {
    agent any
    environment {
        TERRAFORM_VERSION = "1.1.0"
        TERRAFORM_HOME = "${WORKSPACE}/terraform"
    }
    stages {
        stage('Install Terraform') {
            steps {
                sh "wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
                sh "unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d ${TERRAFORM_HOME}"
                sh "export PATH=$PATH:${TERRAFORM_HOME}"
                sh "terraform --version"
            }
        }
        stage('Build') {
            steps {
                sh 'go version'
                sh 'terraform --version'
            }
        }
    }
}
