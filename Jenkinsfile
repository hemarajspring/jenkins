pipeline {
    agent any
    environment {
        TERRAFORM_VERSION = "1.1.0"
        TERRAFORM_HOME = "${WORKSPACE}/terraform"
    }
    stages {
        stage('Install Terraform') {
    steps {
        bat "curl -o terraform_${TERRAFORM_VERSION}_windows_amd64.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_windows_amd64.zip"
        bat "terraform.exe --version"
    }
}
stage('Build') {
    steps {

        bat 'terraform.exe --version'
    }
}
    stage('Init') {
    steps {

        bat 'terraform init'
    }
}
    stage('plan') {
    steps {

        bat 'terraform plan'
    }
}
        stage('apply') {
    steps {
       bat "aws sts get-caller-identity --query 'Account' --output text"
       bat "terraform apply --auto-approve"

    }
}

    }
    
}
