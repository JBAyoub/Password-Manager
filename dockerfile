FROM dart:stable AS builder

WORKDIR /app

COPY pubspec.* ./

RUN dart pub get

COPY . .

RUN dart pub get
RUN dart analyze
RUN dart test
RUN dart compile exe bin/password.dart -o password-manager

FROM debian:bookworm-slim

WORKDIR /app

COPY --from=builder /app/password-manager .

ENTRYPOINT ["./password-manager"]