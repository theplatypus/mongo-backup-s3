# Introduction
This project provides Docker images to periodically back up a MongoDB database to AWS S3, and to restore from the backup as needed.

# Usage
## Backup
```yaml
services:
  mongo:
    image: mongo
    environment:
      MONGO_USER: user
      MONGO_PASSWORD: password

  backup:
    image: mongo-backup-s3
    environment:
      SCHEDULE: '@weekly'                      # optional
      BACKUP_KEEP_DAYS: 7                      # optional
      PASSPHRASE: passphrase                   # optional
      S3_REGION: us-west-1
      S3_ACCESS_KEY_ID: key
      S3_SECRET_ACCESS_KEY: secret
      S3_BUCKET: my-bucket
      S3_PATH: backup
      MONGO_HOST: mongo
      MONGO_PORT: 27017
      MONGO_DATABASE: mydb
      MONGO_USER: user
      MONGO_PASSWORD: password
```

- The `SCHEDULE` variable determines backup frequency. See go-cron schedules documentation [here](http://godoc.org/github.com/robfig/cron#hdr-Predefined_schedules). Omit to run the backup immediately and then exit.
- If `PASSPHRASE` is provided, the backup will be encrypted using GPG.
- Run `docker exec <container name> sh backup.sh` to trigger a backup ad-hoc.
- If `BACKUP_KEEP_DAYS` is set, backups older than this many days will be deleted from S3.
- Set `S3_ENDPOINT` if you're using a non-AWS S3-compatible storage provider.

## Restore
> [!CAUTION]
> DATA LOSS! All database objects will be dropped and re-created.

### ... from latest backup
```sh
docker exec <container name> sh restore.sh
```

> [!NOTE]
> If your bucket has more than a 1000 files, the latest may not be restored -- only one S3 `ls` command is used

### ... from specific backup
```sh
docker exec <container name> sh restore.sh <timestamp>
```

# Development
## Build the image locally
Customize the Dockerfile for MongoDB compatibility. Build the image using:
```sh
DOCKER_BUILDKIT=1 docker build -t your-custom-mongo-backup-image .
```
## Run a simple test environment with Docker Compose
```sh
cp template.env .env
# fill out your secrets/params in .env
docker compose up -d
```

# Acknowledgements
This MongoDB backup project adapts techniques from existing PostgreSQL backup solutions, restructured for simplicity and versatility in MongoDB environments.

## Fork goals
These changes would have incorporated multiple features that are tailored specifically for MongoDB:
  - dedicated repository
  - automated builds
  - support MongoDB specific requirements
  - backup and restore with one image

## Other changes and features
  - uses `mongodump` and `mongorestore` for backup and restoration
  - supports custom backup options via `MONGODUMP_EXTRA_OPTS`
  - supports custom restore options via `MONGORESTORE_EXTRA_OPTS`
  - filter backups on S3 by database name
  - support encrypted (password-protected) backups
  - support for restoring from a specific backup by timestamp
  - support for auto-removal of old backups
```
