pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'naveenkumar492/trend-app'
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
                withCredentials([string(credentialsId: 'dockerhub-pass', variable: 'DOCKER_PASSWORD')]) {
                    sh """
                    echo $DOCKER_PASSWORD | docker login -u naveenkumar492 --password-stdin
                    docker tag trend-app $DOCKER_IMAGE
                    docker push $DOCKER_IMAGE
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s-deployment-service.yaml'
            }
        }
    }
}

