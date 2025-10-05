# Multi-stage Dockerfile for NestJS app
# 1) Build stage: install all deps (including dev) and build the app
# 2) Run stage: install only production deps and copy built output

FROM node:18-alpine AS builder
WORKDIR /app

# Install dependencies (including devDependencies) for building
COPY package*.json ./
RUN npm ci

# Copy source and build
COPY . .
RUN npm run build

# Final image with only production dependencies and build artifacts
FROM node:18-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production

# Install only production dependencies
COPY package*.json ./
RUN npm ci --omit=dev

# Copy built application from builder stage
COPY --from=builder /app/dist ./dist

EXPOSE 3000
CMD ["node", "dist/main.js"]
