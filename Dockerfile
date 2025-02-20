ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION:-3.18}
ARG TARGETARCH

ADD src/install.sh install.sh
RUN sh install.sh && rm install.sh

ENV MONGO_DATABASE=''
ENV MONGO_HOST=''
ENV MONGO_PORT=27017
ENV MONGO_USER=''
ENV MONGO_PASSWORD=''
ENV MONGODUMP_EXTRA_OPTS=''
ENV MONGORESTORE_EXTRA_OPTS=''
ENV S3_ACCESS_KEY_ID=''
ENV S3_SECRET_ACCESS_KEY=''
ENV S3_BUCKET=''
ENV S3_REGION=''
ENV S3_PATH=''
ENV S3_ENDPOINT=''
ENV S3_S3V4='no'
ENV SCHEDULE=''
ENV PASSPHRASE=''
ENV BACKUP_KEEP_DAYS=''

ADD src/run.sh run.sh
ADD src/env.sh env.sh
ADD src/backup.sh backup.sh
ADD src/restore.sh restore.sh

CMD ["sh", "run.sh"]
