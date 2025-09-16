FROM node:18
WORKDIR /app
COPY . .
RUN npm install --omit=dev
ENV NODE_ENV=production
CMD ["npm", "run", "start"]
