# ====================================================================
# Karino Enterprise CRM/HRM - Multi-Stage Production Dockerfile
# Optimized for minimum image size, security, and maximum performance
# ====================================================================

# Step 1: Build stage
FROM node:22-alpine AS builder
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci

# Copy source code and build production assets
COPY . .
RUN npm run build

# Step 2: Production runtime stage
FROM node:22-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000

# Install wget/curl for container healthcheck
RUN apk add --no-cache curl wget

# Copy package descriptors and install only production dependencies
COPY package*.json ./
RUN npm ci --omit=dev

# Copy built server bundle and Vite static frontend assets
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/data ./data

# Persistent storage volume for sqlite/json disk database
VOLUME ["/app/data"]

EXPOSE 3000

# Container healthcheck
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://127.0.0.1:3000/api/health || exit 1

# Start production server
CMD ["node", "dist/server.cjs"]
