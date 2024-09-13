FROM python:3.8-slim-buster

# Définir le répertoire de travail
WORKDIR /usr/src/app

# Mettre à jour les packages et installer pip
RUN apt-get update && \
    apt-get install -y python3-pip

# Copier le fichier des dépendances
COPY requirements.txt .

# Mettre à jour pip et installer les dépendances
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copier le reste du code
COPY . .

# Exposer le port par défaut de Flask
EXPOSE 5000

# Définir la commande par défaut pour exécuter l'application
CMD ["flask", "run", "--host=0.0.0.0"]
