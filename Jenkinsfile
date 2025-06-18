pipeline {
    agent any

    triggers {
        githubPush()
    }

    stages {
        stage('Webhook Check') {
            steps {
                echo "Triggered by GitHub webhook!"
            }
        }
    }
}
