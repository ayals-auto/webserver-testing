FROM node:slim
RUN apt update -y && apt install curl -y
WORKDIR /usr/src/app
COPY . .
EXPOSE 3000
CMD [ "node", "./server.js" ]
