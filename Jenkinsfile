// at the pipeline and stage level
pipeline {
    agent any
    environment {
         nom = 'datascientest'
    }
    stages {
        stage('Example') {
            environment {
                AN_ACCESS_KEY = credentials('DOCKER_HUB_PASS')  // variable secret
                echo $AN_ACCESS_KEY
            }
            steps {
                sh 'print $nom' // variable call
                sh 'print secret  $AN_ACCESS_KEY' // variable call

            }
        }
    }
}