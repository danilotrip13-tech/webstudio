#!/usr/bin/env bash
set -e

DATABASE_URL_VALUE="postgresql://webstudio:${POSTGRES_PASSWORD}@db:5432/webstudio"

mkdir -p /app/apps/builder
mkdir -p /app/packages/prisma-client/prisma
mkdir -p /app/packages/prisma-client

cat > /app/apps/builder/.env.development <<EOF
DEV_LOGIN=${DEV_LOGIN}
AUTH_SECRET=${AUTH_SECRET}
DATABASE_URL=${DATABASE_URL_VALUE}
EOF

cat > /app/packages/prisma-client/.env <<EOF
DATABASE_URL=${DATABASE_URL_VALUE}
EOF

cat > /app/packages/prisma-client/prisma/.env <<EOF
DATABASE_URL=${DATABASE_URL_VALUE}
EOF

cat > /app/.env <<EOF
DATABASE_URL=${DATABASE_URL_VALUE}
DEV_LOGIN=${DEV_LOGIN}
AUTH_SECRET=${AUTH_SECRET}
EOF

echo "Using builder env file:"
cat /app/apps/builder/.env.development

echo "Using prisma env file:"
cat /app/packages/prisma-client/.env

echo "Using prisma schema env file:"
cat /app/packages/prisma-client/prisma/.env

pnpm migrations migrate
pnpm dev --host 0.0.0.0 --port 5173