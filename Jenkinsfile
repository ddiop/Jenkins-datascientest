pipeline {
    agent any

    environment {
        nom = 'datascientest' // Définition de la variable d'environnement globale
    }

    stages {
        stage('Example') {
            environment {
                AN_ACCESS_KEY = credentials('DOCKER_HUB_PASS') // Variable secrète
            }
            steps {
                // Utilisation des variables dans les étapes
                sh 'echo $nom'  // Appel de la variable globale
                sh 'echo secret $AN_ACCESS_KEY'  // Appel de la variable secrète
            }
        }
    }
}