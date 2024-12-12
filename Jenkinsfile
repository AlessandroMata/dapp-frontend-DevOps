pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        DOCKER_IMAGE_NAME = "dapp-frontend"
    }

    stages {
        stage('Checkout') {
            steps {
                // Clonar o repositório
                git url: 'https://github.com/AlessandroMata/dapp-frontend-DevOps.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Construir a imagem Docker com o número de build como tag
                    def buildVersion = env.BUILD_NUMBER
                    def imageName = "${DOCKER_IMAGE_NAME}:${buildVersion}"
                    sh "docker build -t ${imageName} ."
                    env.FULL_IMAGE_NAME = imageName
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Fazer login no Docker Hub manualmente
                    sh "echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin"

                    // Fazer o push da imagem para o Docker Hub
                    sh "docker push ${env.FULL_IMAGE_NAME}"
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