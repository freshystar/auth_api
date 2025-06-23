FROM rust:1.77 AS builder

WORKDIR /app
COPY . .
RUN apt-get update && apt-get install -y pkg-config libssl-dev build-essential
RUN cargo build --release

FROM debian:bullseye-slim
WORKDIR /app
COPY --from=builder /app/target/release/auth_api /app/auth_api
EXPOSE 3000
CMD ["./auth_api"]
