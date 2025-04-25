FROM node:18.17.1

WORKDIR ./
COPY package.json package-lock.json ./

COPY . .
RUN npm ci

#ARG NODE_ENV
ARG FIGMA_API_KEY
ARG PORT

ENV FIGMA_API_KEY ${FIGMA_API_KEY}
ENV PORT ${PORT}

EXPOSE ${PORT}

CMD ["npm", "run", "dev"]
