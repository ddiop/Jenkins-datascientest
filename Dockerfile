FROM jenkins/jenkins:lts

# Passer à l'utilisateur root pour installer les paquets
USER root

# Installer Python3 et pip
RUN apt-get update && apt-get install -y python3 python3-pip

# Revenir à l'utilisateur Jenkins
USER jenkins
