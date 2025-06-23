# Stage 1: Build
FROM rust:1.77 as builder

WORKDIR /app
COPY . .

RUN apt-get update && apt-get install -y libssl-dev pkg-config build-essential

RUN cargo build --release

# Stage 2: Runtime
FROM debian:bullseye-slim

WORKDIR /app
COPY --from=builder /app/target/release/auth_api .

EXPOSE 3000
CMD ["./auth_api"]
