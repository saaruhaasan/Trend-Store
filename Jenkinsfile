pipeline {
    agent any
    environment {
        AWS_REGION = "us-east-1"
        CLUSTER_NAME = "trend-app"
        IMAGE_REPO = "149007322367.dkr.ecr.us-east-1.amazonaws.com/trend-app"
        IMAGE_TAG = "latest"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/saaruhaasan/Trend-Store.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_REPO:$IMAGE_TAG .'
            }
        }
        stage('Push to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION | \
                docker login --username AWS --password-stdin 149007322367.dkr.ecr.$AWS_REGION.amazonaws.com
                docker push $IMAGE_REPO:$IMAGE_TAG
                '''
            }
        }
        stage('Deploy to EKS') {
            steps {
                sh '''
                aws eks update-kubeconfig --region $AWS_REGION --name $CLUSTER_NAME
                kubectl set image deployment/trend-app-deployment trend-app-container=$IMAGE_REPO:$IMAGE_TAG --record
                kubectl rollout status deployment trend-app-deployment
                '''
            }
        }
    }
    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}

