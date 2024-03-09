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
        stage('Plan') {
            steps {
                bat 'terraform plan'
            }
        }
        stage('Assume Role and Apply') {
            steps {
                withCredentials([
                    [
                        $class: 'StringBinding',
                        credentialsId: 'aws-role-name-credentials',
                        variable: 'terraform-cicd'
                    ],
                    [
                        $class: 'StringBinding',
                        credentialsId: 'aws-external-id-credentials',
                        variable: 'terraform-cicd'
                    ]
                ]) {
                    script {
                        def roleName = env.ROLE_NAME
                        def externalId = env.EXTERNAL_ID

                        def credentials = sh(returnStdout: true, script: "aws sts assume-role --role-arn arn:aws:iam::${accountId}:role/${roleName} --role-session-name Jenkins --external-id ${externalId}").trim()

                        def accessKeyId = sh(returnStdout: true, script: "echo '${credentials}' | jq -r '.Credentials.AccessKeyId'").trim()
                        def secretAccessKey = sh(returnStdout: true, script: "echo '${credentials}' | jq -r '.Credentials.SecretAccessKey'").trim()
                        def sessionToken = sh(returnStdout: true, script: "echo '${credentials}' | jq -r '.Credentials.SessionToken'").trim()

                        withCredentials([
                            [$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY', credentialsId: '']],
                            string(credentials: sessionToken, variable: 'AWS_SESSION_TOKEN')
                        ]) {
                            bat "aws sts get-caller-identity --query 'Account' --output text"
                            bat "terraform apply --auto-approve"
                        }
                    }
                }
            }
        }
    }
}
