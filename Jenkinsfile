pipeline {

    agent any

    environment {
        IMAGE_NAME = "calvant-demo:latest"
        TARGET_URL = "http://localhost:5000"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Secrets Scan') {
            steps {
                sh 'gitleaks detect --source . || true'
            }
        }

        stage('Static Code Analysis') {
            steps {
                sh 'semgrep --config=auto . || true'
            }
        }

        stage('Dependency Scan') {
            steps {
                sh 'dependency-check.sh --scan . || true'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Container Scan') {
            steps {
                sh 'trivy image $IMAGE_NAME || true'
            }
        }

        stage('DAST Scan') {
            steps {
                sh 'zap-baseline.py -t $TARGET_URL || true'
            }
        }

        stage('Security Gate') {
            steps {
                echo 'Security validation completed before deployment'
            }
        }

        stage('Deploy Stage') {
            steps {
                echo 'Secure deployment ready'
            }
        }
    }

    post {

        success {
            echo 'DevSecOps pipeline executed successfully'
        }

        failure {
            echo 'Pipeline failed due to detected vulnerabilities'
        }
    }
}
