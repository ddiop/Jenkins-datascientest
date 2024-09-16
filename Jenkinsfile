pipeline {
    agent any
    environment {
         nom = 'datascientest'
    }
    stages {
        stage('Example') {
            environment {
                DOCKER_HUB_PASS = credentials('DOCKER_HUB_PASS')  // variable secret
                GITHUB_TOKEN = credentials('github-access-token')
            }
            steps {
               script {
                    // Utiliser le secret dans une commande shell
                    sh '''
                    echo "The access key is: $GITHUB_TOKEN"
                    '''
                }
                
            }
        }
    }
}
