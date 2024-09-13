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
                    # Construire l'image Docker
                    docker build -t $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG .

                    # Exécuter l'image pour installer les dépendances
                    docker run --rm -v $(pwd):/usr/src/app -w /usr/src/app $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG python3 -m pip install -r requirements.txt
                    '''
                }
            }
        }
        stage('Testing') {
            steps {
                script {
                    sh '''
                    # Exécuter les tests
                    docker run --rm -v $(pwd):/usr/src/app -w /usr/src/app $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG python3 -m unittest discover
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

                    # Exécuter le nouveau conteneur
                    docker run -d -p 8000:5000 --name jenkins $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG
                    '''
                }
            }
        }
    }
}
