pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'naveenkumar492/trend-app'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/naveen23042000/trend-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t trend-app .'
                sh 'docker tag trend-app $DOCKER_IMAGE'
            }
        }

        stage('Login and Push to DockerHub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-pass', variable: 'DOCKER_PASSWORD')]) {
                    sh '''
                    echo $DOCKER_PASSWORD | docker login -u naveenkumar492 --password-stdin
                    docker push $DOCKER_IMAGE
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
                sh 'kubectl apply -f service.yaml'
            }
        }
    }

    post {
        failure {
            echo 'Pipeline failed.'
        }
        success {
            echo 'Pipeline executed successfully!'
        }
    }
}

