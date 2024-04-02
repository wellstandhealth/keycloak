# syntax=docker/dockerfile:1.3
FROM openjdk:22-slim-bookworm

RUN apt-get update && apt-get -y upgrade

COPY quarkus/server/target/lib/quarkus-run.jar /app/app.jar

WORKDIR /app

EXPOSE 7600
EXPOSE 8080

CMD ["java", "-jar", "/app/app.jar", "start-dev"]
