
FROM rust:1.84.0 as builder

WORKDIR /app
COPY . .

# Install OpenSSL and build tools for common crates
RUN apt-get update && apt-get install -y pkg-config libssl-dev build-essential

# Compile the release binary
RUN cargo build --release


FROM debian:bullseye-slim

WORKDIR /app

# Only copy the compiled binary, not cargo or source files
COPY --from=builder /app/target/release/auth_api ./auth_api

# If your app needs a .env file or static files, copy them too:
# COPY .env .env

EXPOSE 3000
CMD ["./auth_api"]
