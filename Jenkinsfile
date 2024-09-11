pipeline {
    agent any
    environment {
    DOCKER_ID = "dstdockerhub"
    DOCKER_IMAGE = "datascientestapi"
    DOCKER_TAG = "v.${BUILD_ID}.0"
    PATH = "${env.PATH}:/usr/local/bin"
    }

    stages {
    stage('Setup') {
            steps {
                script {
                    // Ajouter le chemin d'accès de Python et pip à PATH
                    env.PATH = "${env.PATH}:/usr/local/bin"
                }
            }
        }
        stage('Building') {
            steps {
                  echo "Current PATH: $PATH"
                  sh 'pip install -r requirements.txt'
            }
        }
        stage('Testing') {
            steps {
                  sh 'python -m unittest'
            }
        }
          stage('Deploying') {
          steps{
                script {
              sh '''
              docker rm -f jenkins
              docker build -t $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG .
              docker run -d -p 8000:8000 --name jenkins $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG
              '''
                }
          }
        }
    }
}