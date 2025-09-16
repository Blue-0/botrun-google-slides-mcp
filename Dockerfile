FROM node:18
WORKDIR /app
COPY . .
# Installer d'abord les devDependencies
RUN npm install
RUN npm run build
# Ensuite tu peux supprimer les devDependencies pour une image plus légère si tu veux :
RUN npm prune --production
ENV NODE_ENV=production
CMD ["sh", "-c", "npm run start || tail -f /dev/null"]
