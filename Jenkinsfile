pipeline {
    agent any

    environment {
        DOCKER_ID = "dstdockerhub"
        DOCKER_IMAGE = "datascientestapi"
        DOCKER_TAG = "v.${BUILD_ID}.0"
        IMAGE_NAME = "jenkins-python"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh '''
                    # Construire l'image Docker dynamiquement
                    docker build -t $DOCKER_ID/$IMAGE_NAME:latest .

                    # Taguer l'image avec la version spécifique
                    docker tag $DOCKER_ID/$IMAGE_NAME:latest $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG
                    '''
                }
            }
        }
        stage('Building') {
            steps {
                script {
                    sh '''
                    # Exécuter des commandes dans le conteneur Docker
                    docker run --rm -v $PWD:/app -w /app $DOCKER_ID/$IMAGE_NAME:latest sh -c "
                        # Vérifier la version de Python et pip
                        python3 --version
                        pip3 --version

                        # Mettre à jour pip et installer les dépendances
                        pip3 install --upgrade pip
                        pip3 install -r requirements.txt
                    "
                    '''
                }
            }
        }
        stage('Testing') {
            steps {
                script {
                    sh '''
                    # Exécuter les tests dans le conteneur Docker
                    docker run --rm -v $PWD:/app -w /app $DOCKER_ID/$IMAGE_NAME:latest sh -c "
                        python3 -m unittest discover
                    "
                    '''
                }
            }
        }
        stage('Deploying') {
            steps {
                script {
                    sh '''
                    # Construire l'image Docker pour le déploiement
                    docker build -t $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG .

                    # Supprimer l'ancien conteneur s'il existe
                    docker rm -f jenkins || true

                    # Exécuter le nouveau conteneur
                    docker run -d -p 8000:8000 --name jenkins $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG
                    '''
                }
            }
        }
    }
}
