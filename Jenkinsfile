pipeline {
    agent any

    environment {
        IMAGE_NAME = 'trend-app'
        DOCKER_REPO = 'naveenkumar492'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/naveen23042000/trend-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_REPO}/${IMAGE_NAME} ."
            }
        }

        stage('Login and Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh '''
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                        docker tag trend-app $DOCKER_USERNAME/trend-app
                        docker push $DOCKER_USERNAME/trend-app
                    '''
                }
            }
        }

        stage('Update Kubeconfig') {
            steps {
                // Uncomment and customize below if using Kubernetes deployment
                // withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                //     sh 'export KUBECONFIG=$KUBECONFIG'
                // }
                echo "Kubeconfig update stage (optional, adjust as needed)"
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo "Kubernetes deployment stage (optional, insert kubectl commands here)"
                // Example:
                // sh 'kubectl apply -f k8s/deployment.yaml'
            }
        }
    }

    post {
        failure {
            echo 'Pipeline failed.'
        }
        success {
            echo 'Pipeline completed successfully.'
        }
    }
}

