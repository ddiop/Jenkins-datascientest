# Utiliser une image Python slim comme base
FROM python:3.8-slim-buster

# Définir le répertoire de travail
WORKDIR /usr/src/app

# Définir la variable d'environnement PYTHONPATH
ENV PYTHONPATH=/usr/src/app

# Copier le fichier des dépendances
COPY requirements.txt .

# Mettre à jour pip et installer les dépendances
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copier le reste du code
COPY . .

# Exposer le port par défaut de Flask
EXPOSE 5000

# Créer un utilisateur non-root
RUN useradd -ms /bin/sh appuser
USER appuser

# Définir la commande par défaut pour exécuter l'application
CMD ["flask", "run", "--host=0.0.0.0"]
