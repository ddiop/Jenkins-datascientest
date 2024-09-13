FROM jenkins/jenkins:lts

USER root

# Installer Docker
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce

# Installer Python et pip
RUN apt-get update && apt-get install -y python3 python3-pip

USER jenkins

# Assurez-vous que le répertoire .local/bin est dans le PATH pour pip installé avec --user
ENV PATH="/usr/local/bin:${PATH}"
