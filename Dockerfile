FROM node:18

WORKDIR /app

# Copie tout le code source (inclut Dockerfile, package.json, src/, build/, et ton futur server-http.js)
COPY . .

# Installe toutes les dépendances (dev + prod)
RUN npm install

# Compile le TypeScript (crée le dossier build/)
RUN npm run build

# Installe express pour le wrapper HTTP (si ce n'est pas déjà dans package.json)
RUN npm install express

# Supprime les devDependencies pour alléger l'image
RUN npm prune --production

ENV NODE_ENV=production

# Démarre le serveur HTTP (doit exister dans ton projet !)
CMD ["node", "server-http.js"]
