pipeline {
    agent any

    environment {
        DOCKER_ID = "dstdockerhub"
        DOCKER_IMAGE = "datascientestapi"
        DOCKER_TAG = "v.${BUILD_ID}.0"
        PATH = "${env.PATH}:/Users/ddiop/.pyenv/bin:/Users/ddiop/.pyenv/shims:/usr/local/bin"
    }

    stages {
        stage('Setup Python') {
            steps {
                sh '''
                apt-get update && apt-get install -y python3 python3-pip
                '''
            }
        }
        stage('Building') {
            steps {
                sh '''
                python3 -m pip install --upgrade pip
                pip install -r requirements.txt
                echo "pip install -r requirements.txt"
                '''
            }
        }
        stage('Testing') {
            steps {
                sh '''
                python3 -m unittest discover
                echo "Tests terminés."
                '''
            }
        }
        stage('Deploying') {
            steps {
                sh '''
                docker rm -f jenkins || true
                docker build -t $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG .
                docker run -d -p 8000:8000 --name jenkins $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG
                echo "Déploiement terminé."
                '''
            }
        }
    }
}
