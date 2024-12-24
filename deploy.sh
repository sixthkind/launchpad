#!/bin/bash

# Set up systemd
# https://pocketbase.io/docs/going-to-production/
# nano /lib/systemd/system/pocketbase.service

# Load environment variables
set -a  # automatically export all variables
source .env
set +a  # stop automatically exporting

ssh ${SERVER_USER}@${SERVER_HOST} << ENDSSH
  cd ${APP_PATH}
  systemctl stop pocketbase
  rm package-lock.json
  git pull
  npm install
  npm run generate
  rm -rf pocketbase/pb_public
  mkdir pocketbase/pb_public
  cp -r .output/public/* pocketbase/pb_public
  systemctl start pocketbase
ENDSSH
