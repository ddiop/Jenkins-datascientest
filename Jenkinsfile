pipeline {
    agent any
    environment {
        DOCKER_ID = "dstdockerhub"
        DOCKER_IMAGE = "datascientestapi"
        DOCKER_TAG = "v.${BUILD_ID}.0"
        PYTHON_PATH = "/Users/ddiop/.pyenv/shims:/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin"
    }
    stages {
        stage('Building') {
            steps {
                script {
                    sh '''
                    # Exporter le PATH pour inclure les chemins nécessaires
                    export PATH=${PYTHON_PATH}:${PATH}

                    # Vérifier les versions de Python et pip
                    python3 --version
                    pip3 --version

                    # Mettre à jour pip et installer les dépendances
                    pip3 install --upgrade pip
                    pip3 install -r requirements.txt
                    '''
                }
            }
        }
        stage('Testing') {
            steps {
                script {
                    sh '''
                    # Exécuter les tests
                    python3 -m unittest discover
                    '''
                }
            }
        }
        stage('Deploying') {
            steps {
                script {
                    sh '''
                    # Supprimer l'ancien conteneur s'il existe
                    docker rm -f jenkins || true

                    # Construire l'image Docker
                    docker build -t $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG .

                    # Exécuter le nouveau conteneur
                    docker run -d -p 8000:8000 --name jenkins $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG
                    '''
                }
            }
        }
    }
}
