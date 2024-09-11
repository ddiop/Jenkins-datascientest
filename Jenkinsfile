pipeline {
    agent any
    environment {
    DOCKER_ID = "dstdockerhub"
    DOCKER_IMAGE = "datascientestapi"
    DOCKER_TAG = "v.${BUILD_ID}.0"
    PATH = "${env.PATH}:/Users/ddiop/.pyenv/shims"
    }

    stages {

        stage('Building') {
            steps {
                sh '''
                export PATH="$HOME/.pyenv/bin:$PATH"
                eval "$(pyenv init --path)"
                eval "$(pyenv virtualenv-init -)"
                pip install --upgrade pip
                pip install -r requirements.txt
                '''
            }
        }
        stage('Testing') {
            steps {
                  sh '''
                export PATH="$HOME/.pyenv/bin:$PATH"
                eval "$(pyenv init --path)"
                eval "$(pyenv virtualenv-init -)"
                python -m unittest
                '''
            }
        }
          stage('Deploying') {
          steps{
                script {
              sh '''
                    export PATH="$HOME/.pyenv/bin:$PATH"
                    eval "$(pyenv init --path)"
                    eval "$(pyenv virtualenv-init -)"
                    docker rm -f jenkins || true
                    docker build -t $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG .
                    docker run -d -p 8000:8000 --name jenkins $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG
                    '''
                }
          }
        }
    }
}