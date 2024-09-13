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
                script {
                    sh '''
                    # Vérifier la version de Python et pip
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
