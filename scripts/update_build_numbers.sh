#!/bin/bash

awk "{gsub(/DEV-0/,$(cat keycloak-build-number.txt)); print}" Dockerfile.tmpl > Dockerfile

awk "{gsub(/DEV-0/,$(cat keycloak-build-number.txt)); print}" pom.xml > pom.xml.tmp \
&& mv pom.xml.tmp pom.xml