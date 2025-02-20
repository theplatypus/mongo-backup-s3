if [ -z "$S3_BUCKET" ]; then
  echo "You need to set the S3_BUCKET environment variable."
  exit 1
fi

if [ -z "$MONGO_DATABASE" ]; then
  echo "You need to set the MONGO_DATABASE environment variable."
  exit 1
fi

if [ -z "$MONGO_HOST" ]; then
  # https://docs.docker.com/network/links/#environment-variables
  if [ -n "$MONGO_PORT_27017_TCP_ADDR" ]; then
    MONGO_HOST=$MONGO_PORT_27017_TCP_ADDR
    MONGO_PORT=$MONGO_PORT_27017_TCP_PORT
  else
    echo "You need to set the MONGO_HOST environment variable."
    exit 1
  fi
fi

if [ -z "$MONGO_USER" ]; then
  echo "You need to set the MONGO_USER environment variable."
  exit 1
fi

if [ -z "$MONGO_PASSWORD" ]; then
  echo "You need to set the MONGO_PASSWORD environment variable."
  exit 1
fi

if [ -z "$S3_ENDPOINT" ]; then
  aws_args=""
else
  aws_args="--endpoint-url $S3_ENDPOINT"
fi


if [ -n "$S3_ACCESS_KEY_ID" ]; then
  export AWS_ACCESS_KEY_ID=$S3_ACCESS_KEY_ID
fi
if [ -n "$S3_SECRET_ACCESS_KEY" ]; then
  export AWS_SECRET_ACCESS_KEY=$S3_SECRET_ACCESS_KEY
fi
export AWS_DEFAULT_REGION=$S3_REGION
