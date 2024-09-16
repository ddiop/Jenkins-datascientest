pipeline {
    agent any
    environment {
         nom = 'datascientest'
    }
    stages {
        stage('Example') {
            environment {
                DOCKER_HUB_PASS = credentials('DOCKER_HUB_PASS')  // variable secret
               github-access-token = credentials('github-access-token')
            }
            steps {
                sh 'print $DOCKER_HUB_PASS' // variable call
                 sh 'print $github-access-token' // variable call
            }
        }
    }
}
