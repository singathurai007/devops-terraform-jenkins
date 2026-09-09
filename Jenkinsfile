pipeline {

    agent any

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/YOUR_USERNAME/devops-terraform-jenkins.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                    cd terraform
                    terraform init
                '''
            }
        }

        stage('Terraform Validate') {
            steps {
                sh '''
                    cd terraform
                    terraform validate
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                    cd terraform
                    terraform plan \
                    -var="ami_id=${AMI_ID}"
                '''
            }
        }

        stage('Approval') {
            steps {
                input message: 'Deploy infrastructure?'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh '''
                    cd terraform
                    terraform apply -auto-approve \
                    -var="ami_id=${AMI_ID}"
                '''
            }
        }

        stage('Deployment Complete') {
            steps {
                sh '''
                    cd terraform
                    terraform output
                '''
            }
        }
    }
}