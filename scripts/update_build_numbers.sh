#!/bin/bash

awk "{gsub(/DEV-0/,$(cat keycloak-build-number.txt)); print}" Dockerfile.tmpl > Dockerfile