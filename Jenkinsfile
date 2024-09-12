pipeline {
    agent any
    environment {
        DOCKER_ID = "dstdockerhub"
        DOCKER_IMAGE = "datascientestapi"
        DOCKER_TAG = "v.${BUILD_ID}.0"

    }

    stages {
        stage('Building') {
            steps {
                sh '''
                env.PATH = "${env.PATH}:/Users/ddiop/.pyenv/bin:/Users/ddiop/.pyenv/shims:/usr/local/bin"
                pip install -r requirements.txt
                docker build -t $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG .
                '''
            }
        }
        stage('Testing') {
            steps {
                sh '''

                python -m unittest

                '''
            }
        }
        stage('Deploying') {
            steps {
                script {
                    sh '''

                    docker rm -f jenkins || true

                    docker run -d -p 8000:8000 --name jenkins $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG

                    '''
                }
            }
        }
    }
}

