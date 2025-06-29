pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "naveenkumar492/trend-app"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/naveen23042000/trend-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Login and Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh '''
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                        docker tag trend-app $DOCKER_IMAGE
                        docker push $DOCKER_IMAGE
                    '''
                }
            }
        }

        stage('Update Kubeconfig') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-credentials', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh '''
                        aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                        aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                        aws eks --region us-west-2 update-kubeconfig --name trend-cluster
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s-deployment-service.yaml --validate=false'
            }
        }
    }

    post {
        failure {
            echo 'Pipeline failed.'
        }
    }
}

