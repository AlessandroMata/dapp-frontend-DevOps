FROM node:20-slim AS builder

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /app
COPY ./ ./
ENV PATH /usr/src/code/node_modules/.bin:$PATH
RUN pnpm install
RUN pnpm build


FROM nginx:alpine

WORKDIR /usr/share/nginx/html
RUN rm -rf ./* && rm -rf /etc/nginx/conf.d/*
COPY ./web-server.conf /etc/nginx/conf.d/
COPY --from=builder /app/dist ./
