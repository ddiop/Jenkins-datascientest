# Utiliser l'image Jenkins LTS comme base
FROM jenkins/jenkins:lts

# Passer à l'utilisateur root pour installer des packages
USER root

# Mettre à jour les paquets et installer Python et pip
RUN apt-get update && apt-get install -y python3 python3-pip

# Réinitialiser à l'utilisateur Jenkins pour éviter les problèmes de permissions
USER jenkins

# Assurez-vous que le répertoire .local/bin est dans le PATH pour pip installé avec --user
ENV PATH="/usr/local/bin:${PATH}"
