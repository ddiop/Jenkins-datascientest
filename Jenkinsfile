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

                echo "Building"
                '''
            }
        }
        stage('Testing') {
            steps {
                sh '''
  echo "Testing"

                '''
            }
        }
        stage('Deploying') {
            steps {
                script {
                    sh '''

                   echo "deploying"
                    '''
                }
            }
        }
    }
}
