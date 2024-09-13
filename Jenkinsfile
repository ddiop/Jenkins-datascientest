pipeline {
    agent any

    environment {
        DOCKER_ID = "dstdockerhub"
        DOCKER_IMAGE = "datascientestapi"
        DOCKER_TAG = "v.${BUILD_ID}.0"
        DOCKER_PATH = "/usr/local/bin"
    }

    stages {
        stage('Building') {
            steps {
                script {
                    // Ajouter le chemin Docker à la variable PATH
                    sh '''
                    export PATH=${DOCKER_PATH}:${PATH}

                    # Vérifier que Docker est accessible
                    docker --version

                    # Mettre à jour pip et installer les dépendances
                    pip install --upgrade pip
                    pip install -r requirements.txt

                    # Construire l'image Docker
                    docker build -t $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG .
                    '''
                }
            }
        }
        stage('Testing') {
            steps {
                sh '''
                # Exécuter les tests
                python -m unittest discover
                '''
            }
        }
        stage('Deploying') {
            steps {
                sh '''
                # Supprimer l'ancien conteneur s'il existe
                docker rm -f jenkins || true

                # Exécuter le nouveau conteneur
                docker run -d -p 8000:8000 --name jenkins $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG
                '''
            }
        }
    }
}
