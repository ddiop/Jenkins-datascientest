# Utilise l'image officielle Python 3.8 basée sur Debian Buster
FROM python:3.8-slim-buster

# Définit le répertoire de travail à l'intérieur du conteneur
WORKDIR /usr/src/app

# Copie le fichier des dépendances dans le conteneur
COPY requirements.txt ./

# Installe les dépendances
RUN pip install --no-cache-dir -r requirements.txt

# Copie le contenu de l'application dans le conteneur
COPY . .

# Expose le port utilisé par l'application Flask
EXPOSE 5000

# Définit la commande par défaut pour exécuter l'application Flask
CMD ["flask", "run", "--host=0.0.0.0"]