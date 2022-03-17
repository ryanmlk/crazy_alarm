FROM node:14-alpine3.13
WORKDIR /app
COPY . .
RUN npm install
EXPOSE 3000/tcp
CMD ["node", "server.js"]