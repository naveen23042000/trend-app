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
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Login and Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-pass', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
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
                echo 'Kubeconfig step will be added here...'
                // Add your AWS EKS or kubeconfig update steps here
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo 'Deployment step will be added here...'
                // Add your kubectl apply -f k8s-deployment.yaml or similar
            }
        }
    }

    post {
        failure {
            echo 'Pipeline failed.'
        }
        success {
            echo 'Pipeline succeeded.'
        }
    }
}

