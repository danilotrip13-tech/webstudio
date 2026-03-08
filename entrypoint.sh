#!/usr/bin/env bash
set -e

mkdir -p /app/apps/builder

cat > /app/apps/builder/.env.development <<EOF
DEV_LOGIN=${DEV_LOGIN}
AUTH_SECRET=${AUTH_SECRET}
DATABASE_URL=postgresql://webstudio:${POSTGRES_PASSWORD}@db:5432/webstudio
EOF

echo "Using builder env file:"
cat /app/apps/builder/.env.development

pnpm migrations migrate
pnpm dev --host 0.0.0.0 --port 5173