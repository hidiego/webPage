FROM dcorral3/angular-cli-arm as builder
WORKDIR /app
COPY package.json /app/package.json
RUN npm install
COPY . /app
RUN ./node_modules/.bin/ng build --prod --output-path ./dist/out

FROM nginx:alpine
COPY --from=builder /app/dist/out/ /usr/share/nginx/html
COPY --from=builder /app/nginx.conf /etc/nginx/conf.d/default.conf
