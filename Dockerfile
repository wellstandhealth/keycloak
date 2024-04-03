# syntax=docker/dockerfile:1.3
# FROM openjdk:23-slim as ubi-micro-build
FROM registry.access.redhat.com/ubi9 AS ubi-micro-build

RUN dnf install -y tar gzip

ENV KEYCLOAK_VERSION 999.0.0-SNAPSHOT
ARG KEYCLOAK_DIST=quarkus/dist/target/keycloak-$KEYCLOAK_VERSION.tar.gz
ADD $KEYCLOAK_DIST /tmp/keycloak/

# The next step makes it uniform for local development and upstream built.
# If it is a local tar archive then it is unpacked, if from remote is just downloaded.
RUN (cd /tmp/keycloak && \
    tar -xvf /tmp/keycloak/keycloak-*.tar.gz && \
    rm /tmp/keycloak/keycloak-*.tar.gz) || true

RUN mv /tmp/keycloak/keycloak-* /opt/keycloak && mkdir -p /opt/keycloak/data
RUN chmod -R g+rwX /opt/keycloak

ADD quarkus/container/ubi-null.sh /tmp/
RUN bash /tmp/ubi-null.sh java-17-openjdk-headless glibc-langpack-en findutils

# FROM openjdk:23-slim
FROM registry.access.redhat.com/ubi9-micro

ENV KC_RUN_IN_CONTAINER true
ENV LANG en_US.UTF-8

COPY --from=ubi-micro-build /tmp/null/rootfs/ /
COPY --from=ubi-micro-build --chown=1000:0 /opt/keycloak /opt/keycloak

RUN echo "keycloak:x:0:root" >> /etc/group && \
    echo "keycloak:x:1000:0:keycloak user:/opt/keycloak:/sbin/nologin" >> /etc/passwd

USER 1000

EXPOSE 8080
EXPOSE 7600
EXPOSE 8443

ENTRYPOINT [ "/opt/keycloak/bin/kc.sh" ]
