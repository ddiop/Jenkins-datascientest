pipeline {
    agent any

    environment {
        DOCKER_ID = "dstdockerhub"
        DOCKER_IMAGE = "datascientestapi"
        DOCKER_TAG = "v.${BUILD_ID}.0"
        PYTHON_PATH = "/Users/ddiop/.pyenv/bin:/Users/ddiop/.pyenv/shims:/usr/local/bin"
    }

    stages {
        stage('Building') {
            steps {
                script {
                    sh '''
                    # Exporter le PATH avec les chemins spécifiques
                    export PATH="${PYTHON_PATH}:${PATH}"

                    # Mettre à jour pip
                    pip install --upgrade pip

                    # Installer les dépendances
                    pip install -r requirements.txt
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

                # Construire l'image Docker
                docker build -t $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG .

                # Exécuter le nouveau conteneur
                docker run -d -p 8000:8000 --name jenkins $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG
                '''
            }
        }
    }
}
