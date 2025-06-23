# Stage 1: Build the app using Rust official image
FROM rust:1.77 AS builder

WORKDIR /app
COPY . .

# Install needed packages
RUN apt-get update && apt-get install -y pkg-config libssl-dev

# Build statically-linked binary
RUN cargo build --release

# Stage 2: Minimal Alpine image
FROM alpine:3.20

# Install only minimal dependencies
RUN apk add --no-cache libgcc

WORKDIR /app

# Copy the built binary from stage 1
COPY --from=builder /app/target/release/auth_api .

# Expose the port your app listens on
EXPOSE 3000

# Run the binary
CMD ["./auth_api"]
