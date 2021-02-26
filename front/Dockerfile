FROM node:12.5.0-alpine

ARG WORKDIR
ARG CONTAINER_PORT
ARG API_URL

ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    HOST=0.0.0.0 \
    API_URL=${API_URL}
# ENV PATH ${HOME}/node_modules/.bin:$PATH

WORKDIR ${HOME}
# ADD . ${WORKDIR}

COPY package.json .

RUN apk update && \
    apk upgrade && \
    npm install -g n && \
    yarn install &&\
    rm -rf /var/cache/apk/*

EXPOSE ${CONTAINER_PORT}

CMD ["yarn", "dev"]