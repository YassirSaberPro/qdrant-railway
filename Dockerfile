# Qdrant Vector Database for Railway
FROM qdrant/qdrant:latest

# Qdrant uses port 6333 for both HTTP and gRPC
EXPOSE 6333

# Persistent storage configuration
ENV QDRANT__STORAGE__STORAGE_PATH=/qdrant/storage
ENV QDRANT__STORAGE__SNAPSHOTS_PATH=/qdrant/snapshots

# Performance tuning for Railway
ENV QDRANT__SERVICE__HTTP_PORT=6333
ENV QDRANT__SERVICE__GRPC_PORT=6333
ENV QDRANT__SERVICE__MAX_REQUEST_SIZE_MB=100

# Logging
ENV QDRANT__LOG_LEVEL=INFO

# Create storage directory
RUN mkdir -p /qdrant/storage /qdrant/snapshots

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:6333/healthz || exit 1
