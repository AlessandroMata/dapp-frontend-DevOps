pipeline {
    agent {
        docker {
            image 'node:20-slim' // Define a imagem base para o ambiente de construção.
        }
    }

    environment {
        DOCKER_CREDENTIALS_ID = '330752ff-80a5-46ed-97e4-fdb900ea4fc0'
        REPOSITORY_URL = 'https://your-repository-url-here.git'
    }

    stages {
        stage('Checkout') {
            steps {
                // Clonar o repositório
                git url: env.REPOSITORY_URL
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Construir a imagem Docker com nome dinâmico baseado no BUILD_ID
                    def imageName = "stable-${env.BUILD_ID}"
                    sh "docker build -t ${imageName} ."
                    env.DOCKER_IMAGE_NAME = imageName
                }
            }
        }

        stage('Login to DockerHub') {
            steps {
                script {
                    // Fazer login no Docker Hub
                    withCredentials([string(credentialsId: env.DOCKER_CREDENTIALS_ID, variable: 'DOCKER_PASSWORD')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u 'alecioferreira' --password-stdin"
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Fazer o push da imagem para o Docker Hub
                    sh "docker push ${env.DOCKER_IMAGE_NAME}"
                }
            }
        }
    }

    post {
        always {
            // Limpeza de imagens locais para evitar acúmulo no servidor Jenkins
            sh 'docker image prune -af'
        }
        success {
            echo 'Build and push completed successfully!'
        }
        failure {
            echo 'Build or push failed.'
        }
    }
}
