#!/bin/bash

# Set up systemd
# https://pocketbase.io/docs/going-to-production/
# nano /lib/systemd/system/pocketbase.service

# Load environment variables
set -a  # automatically export all variables
source .env.production
set +a  # stop automatically exporting

ssh ${SERVER_USER}@${SERVER_IP} << ENDSSH
  # Kill existing pocketbase process
  if lsof -ti:${APP_PORT}; then
    lsof -ti:${APP_PORT} | xargs kill
  fi

  # Check if app directory exists, pull changes
  if [ ! -d "${SERVER_PATH}" ]; then
    echo "App directory not found. Cloning repository..."
    git clone ${APP_REPO} ${SERVER_PATH}
    cd ${SERVER_PATH}
  else
    cd ${SERVER_PATH}
    git fetch origin
    git reset --hard origin/main
  fi

  # Clean
  rm -rf node_modules
  rm pocketbase/pocketbase
  rm pocketbase/CHANGELOG.md
  rm pocketbase/LICENSE.md
  apt install unzip
  unzip pocketbase/pocketbase_*_linux_amd64.zip -d pocketbase/
  chmod +x pocketbase/pocketbase
  pocketbase/pocketbase superuser upsert ${ADMIN_EMAIL} ${ADMIN_PW}

  # Build App
  npm install
  npm run generate
  rm -rf pocketbase/pb_public
  mkdir pocketbase/pb_public
  cp -r .output/public/* pocketbase/pb_public

  # Start new pocketbase instance
  if [ -n "${APP_URL}" ]; then
    nohup pocketbase/pocketbase serve ${APP_URL} >/dev/null 2>&1 &
  else
    nohup pocketbase/pocketbase serve --http=0.0.0.0:${APP_PORT} >/dev/null 2>&1 &
  fi
  echo "App deployed"
ENDSSH
