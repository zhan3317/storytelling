# Multi-stage build
FROM node:20-alpine AS build
WORKDIR /app
COPY client ./client
RUN npm ci --prefix client && npm run build --prefix client

FROM node:20-alpine AS server
WORKDIR /app
COPY server ./server
COPY --from=build /app/client/dist ./client/dist
WORKDIR /app/server
RUN npm ci
ENV PORT=8787
EXPOSE 8787
CMD ["node", "index.js"]
