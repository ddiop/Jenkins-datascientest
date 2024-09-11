pipeline {
    agent any
    server {
    listen 4040;
    server_name https://8fa0-2a01-e0a-254-7680-a4f7-9ea8-a3d-754.ngrok-free.app;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
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
