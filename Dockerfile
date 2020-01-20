#step 1 build process
FROM node as build-deps
WORKDIR /usr/src/app
COPY package*.json ./

RUN yarn
COPY . .
RUN yarn build
#EXPOSE 80

#step 2 prepare nginx as web server
FROM nginx:1.16.0-alpine
COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html

COPY mydefault.conf /etc/nginx/nginx.conf

EXPOSE 80
