def dockerImage

pipeline {
    agent any
    
    environment {
        SONARQUBE = 'sonar-server' // Use the actual name from Jenkins → Configure System
        DOCKERHUB_CREDENTIALS = 'docker-cred'
        IMAGE_NAME = 'abhishek365/golf-ci-cd'
    }

    stages {
        stage('GitHub Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/abhijha16/Golf-Club-AWS-Deployment-Pipeline.git']])
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                def scannerHome = tool 'sonar-scanner'
                withSonarQubeEnv("${SONARQUBE}") {
                    sh """
                    ${scannerHome}/bin/sonar-scanner \
                    -Dsonar.projectKey=Golf-Club-AWS-Deployment-Pipeline \
                    -Dsonar.projectName=Golf-Club-AWS-Deployment-Pipeline \
                    -Dsonar.sources=. \
                    -Dsonar.sourceEncoding=UTF-8 \
                    -Dsonar.inclusions=**/*.html,**/*.css,**/*.js
                    """
                }
              }
            }
        }
        stage('Retire.js Scan') {
            steps {
                 script {
                        sh '''
                           docker run --rm \
                           -v $(pwd):/app \
                           gruebel/retirejs \
                           --path /app \
                           --outputpath /app/retire-report.html || true
                           '''
               }
            } 
        }
        stage('Check Docker Version') {
            steps {
                sh 'docker -v'
            }
        }
        stage('Docker Build Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}:latest", ".")
                }
            }
        }
        stage('Docker Push') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'Docker') {
                        sh "docker push ${dockerImage.imageName()}"
                    }
                }
            }
        }
        stage('Triggering GOLF_CD Job') {
            steps {
                build job: 'GOLF_CD',
                wait: false,
                parameters: [
                    string(name: 'IMAGE_NAME', value: "${dockerImage.imageName()}")
                    ]
            }
        }
    }
    post {
        always {
            echo 'Pipeline Completed!'
            archiveArtifacts artifacts: 'retire-report.html', allowEmptyArchive: true  // Archive the report so it shows up in Jenkins build artifacts
            publishHTML([
                reportDir: '.',
                reportFiles: 'retire-report.html',
                reportName: 'Retire Report',
                keepAll: true,
                alwaysLinkToLastBuild: true,
                allowMissing: false
                ])
        }
        failure {
            echo 'Job Failed! Please Check'
        }
    }
}
