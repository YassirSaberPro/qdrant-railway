# Qdrant Vector Database for Railway
FROM qdrant/qdrant:latest

# Install curl for healthcheck
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Qdrant uses port 6333 for HTTP and 6334 for gRPC
EXPOSE 6333 6334

# Persistent storage configuration
ENV QDRANT__STORAGE__STORAGE_PATH=/qdrant/storage
ENV QDRANT__STORAGE__SNAPSHOTS_PATH=/qdrant/snapshots

# Performance tuning for Railway
ENV QDRANT__SERVICE__HTTP_PORT=6333
ENV QDRANT__SERVICE__GRPC_PORT=6334
ENV QDRANT__SERVICE__MAX_REQUEST_SIZE_MB=100

# Logging
ENV QDRANT__LOG_LEVEL=INFO

# Create storage directory
RUN mkdir -p /qdrant/storage /qdrant/snapshots

# Default entrypoint from base image
