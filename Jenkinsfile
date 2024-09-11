pipeline {
    agent {
     docker {
       image 'gradle:6.9-alpine'
       label 'datascientest-gradle'
       args  '-v /tmp:/tmp'
     }
   }
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
                # Ajouter pyenv et docker au chemin
                export PATH="/Users/ddiop/.pyenv/bin:/usr/local/bin:$PATH"
                # Initialiser pyenv
                eval "$(pyenv init --path)"
                eval "$(pyenv init -)"
                eval "$(pyenv virtualenv-init -)"
                # Mettre à jour pip
                pip install --upgrade pip
                # Installer les dépendances
                pip install -r requirements.txt
                '''
            }
        }
        stage('Testing') {
            steps {
                sh '''
                export PATH="/Users/ddiop/.pyenv/bin:/usr/local/bin:$PATH"
                eval "$(pyenv init --path)"
                eval "$(pyenv virtualenv-init -)"
                python -m unittest
                '''
            }
        }
        stage('Deploying') {
            steps {
                script {
                    sh '''
                    export PATH="/Users/ddiop/.pyenv/bin:/usr/local/bin:$PATH"
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
