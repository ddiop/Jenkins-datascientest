pipeline {
    agent any
    environment {
        DOCKER_ID = "dstdockerhub"
        DOCKER_IMAGE = "datascientestapi"
        DOCKER_TAG = "v.${BUILD_ID}.0"
        PATH = "${env.PATH}:/Users/ddiop/.pyenv/bin:/Users/ddiop/.pyenv/shims:/usr/local/bin"
    }

    stages {
        stage('Building') {
            steps {
                sh '''


                # Installer les dépendances
                echo "pip install -r requirements.txt"
                '''
            }
        }
        stage('Testing') {
            steps {
                sh '''


                '''
            }
        }
        stage('Deploying') {
            steps {
                script {
                    sh '''


                    '''
                }
            }
        }
    }
}
