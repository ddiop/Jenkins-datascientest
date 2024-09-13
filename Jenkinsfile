pipeline {
    agent any
    environment {
        DOCKER_ID = "dstdockerhub"
        DOCKER_IMAGE = "datascientestapi"
        DOCKER_TAG = "v.${BUILD_ID}.0"
        // Ajoutez ici le chemin vers pip et python si nécessaire
        // PYTHON_PATH = "/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin"
    }
    stages {
        stage('Building') {
            steps {
                script {
                    // Vérifiez que pip et python sont accessibles
                    sh '''
                    echo "Updating pip..."
                    pip install --upgrade pip

                    echo "Installing dependencies..."
                    pip install -r requirements.txt
                    '''
                }
            }
        }
        stage('Testing') {
            steps {
                script {
                    // Exécutez les tests unitaires
                    sh '''
                    echo "Running tests..."
                    python -m unittest discover
                    '''
                }
            }
        }
        stage('Deploying') {
            steps {
                script {
                    // Exécutez les étapes de déploiement ici
                    sh '''
                    echo "Removing old container if exists..."
                    docker rm -f jenkins || true

                    echo "Building Docker image..."
                    docker build -t $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG .

                    echo "Running Docker container..."
                    docker run -d -p 8000:8000 --name jenkins $DOCKER_ID/$DOCKER_IMAGE:$DOCKER_TAG
                    '''
                }
            }
        }
    }
}
