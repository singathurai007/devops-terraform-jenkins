pipeline {

    agent any

    environment {
        AMI_ID = 'ami-06033d1583f2e66ec'
        AWS_REGION = 'ap-south-1'
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Code checkout completed by Jenkins SCM'
            }
        }

        stage('Check Tools') {
            steps {
                sh '''
                    terraform --version
                    aws --version
                '''
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
                input message: 'Deploy infrastructure?', ok: 'Deploy'
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

       stage('Docker Deploy') {
    steps {
        sh '''
            cd app
            docker build -t devops-web .
            docker stop devops-web || true
            docker rm devops-web || true
            docker run -d --name devops-web -p 80:80 devops-web
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
