FROM dcorral3/angular-cli-8.3.3 as builder
COPY package.json package.json
RUN npm install
COPY . .
RUN ./node_modules/.bin/ng build --prod --output-path ./dist/out

FROM nginx:alpine
COPY --from=builder /dist/out/ /usr/share/nginx/html
COPY --from=builder /nginx.conf /etc/nginx/conf.d/default.conf
