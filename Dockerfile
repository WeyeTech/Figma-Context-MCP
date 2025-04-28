FROM node:18.17.1

WORKDIR /app
COPY package.json package-lock.json ./

RUN npm ci

COPY . .

# Build the application
RUN npm run build

ARG FIGMA_API_KEY
ARG PORT

ENV FIGMA_API_KEY ${FIGMA_API_KEY}
ENV PORT ${PORT}

EXPOSE ${PORT}

CMD ["npm", "run", "start"]
