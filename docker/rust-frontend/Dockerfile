FROM rust:1.75 AS builder
WORKDIR /app

COPY Cargo.toml Cargo.toml
COPY src src
RUN cargo build --release

FROM debian:bookworm-slim
WORKDIR /app
COPY --from=builder /app/target/release/rust-frontend /usr/local/bin/rust-frontend

EXPOSE 3000
CMD ["rust-frontend"]
