
# create temporary container
FROM node:alpine as builder

# ENV http_proxy="http://httpproxy.bfm.com:8080"  \
#     https_proxy="http://sftpproxy.bfm.com:8080"

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Bring over just the build folder and run start nginx
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
