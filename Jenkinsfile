pipeline {
    agent any
    environment {
        DOCKER_ID = "dstdockerhub"
        DOCKER_IMAGE = "datascientestapi"
        DOCKER_TAG = "v.${BUILD_ID}.0"
        PYTHON_PATH = "/Users/ddiop/.pyenv/shims:/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin"
        PIP_PATH = "/Users/ddiop/.pyenv/shims/pip3"
    }
    stages {
        stage('Checking Paths') {
            steps {
                script {
                    sh '''
                    # Vérifier le contenu du répertoire de pip3
                    ls -l /Users/ddiop/.pyenv/shims
                    '''
                }
            }
        }
    }
}
