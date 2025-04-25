FROM node:18.17.1 as build

WORKDIR /app

ARG APP_ENV

COPY package.json package-lock.json ./

RUN npm ci

COPY . .

RUN npm i rollup-plugin-import-css

RUN npm run install:${APP_ENV}

FROM node:18.17.1-alpine

WORKDIR /app

ARG APP_ENV

ENV APP_ENV ${APP_ENV}
#COPY --from=build /app/.env.${APP_ENV} ./
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/public ./public
COPY --from=build /app/.next ./.next
COPY --from=build /app/package.json ./
COPY --from=build /app/package-lock.json ./

EXPOSE 3000

ENV PORT 3000

CMD ["npm", "run", "dev"]
