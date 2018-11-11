FROM node:6.14.4-alpine

RUN apk update && apk add bash curl
WORKDIR /usr/src/app

COPY . .

RUN npm install

EXPOSE 3000
CMD [ "npm", "start" ]
