FROM node:22-alpine

WORKDIR /app

# Enable pnpm via Corepack (ships with Node)
RUN corepack enable

# Install deps first (better layer caching)
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

COPY . .

EXPOSE 5173

CMD ["pnpm", "dev", "--host", "0.0.0.0", "--port", "5173"]

