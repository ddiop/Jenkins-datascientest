pipeline {
    agent any

    environment {
        DOCKER_ID = "dstdockerhub" // Remplacez par votre Docker ID
        DOCKER_IMAGE = "datascientestapi"
        DOCKER_TAG = "v.${BUILD_ID}.0"
        PATH = "${env.PATH}:/Users/ddiop/.pyenv/bin:/Users/ddiop/.pyenv/shims:/usr/local/bin"
    }

    stages {
        stage('Building') {
            steps {
                script {
                    // Utiliser l'utilisateur root pour installer pip si nécessaire
                    sh '''
                    # Mettre à jour pip
                    python3 -m pip install --upgrade pip
                    # Installer les dépendances
                    pip install -r requirements.txt
                    echo "Dépendances installées avec succès."
                    '''
                }
            }
        }
        stage('Testing') {
            steps {
                script {
                    sh '''
                    # Lancer les tests unitaires
                    python3 -m unittest discover
                    echo "Tests terminés."
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
                    # Exécuter le conteneur Docker
                    docker run -d -p 8000:8000 --name jenkins $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG
                    echo "Déploiement terminé."
                    '''
                }
            }
        }
    }
}
