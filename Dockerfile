
# create temporary container
FROM node:alpine

# ENV http_proxy="http://httpproxy.bfm.com:8080"  \
#     https_proxy="http://sftpproxy.bfm.com:8080"

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Bring over just the build folder and run start nginx
FROM nginx
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html
