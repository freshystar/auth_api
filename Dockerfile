FROM rust:1.84.0

WORKDIR /app
COPY . .

RUN apt-get update && apt-get install -y pkg-config libssl-dev build-essential

RUN cargo build --release

ENV PORT=3000
EXPOSE 3000

CMD ["./target/release/auth_api"]
