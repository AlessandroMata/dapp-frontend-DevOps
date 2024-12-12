pipeline {
    agent any

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
                    // Construir a imagem Docker
                    sh "docker build -t dapp-frontend:latest ."
                }
            }
        }
    }
}
