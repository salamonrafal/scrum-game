# syntax=docker/dockerfile:1
FROM node:12.18.1
WORKDIR /service

COPY . .
COPY ./docker/.env.prod .env

RUN npm install \
    && npm run prebuild \
    && npm run build

EXPOSE 3000

CMD [ "npm", "run", "start::prod"]