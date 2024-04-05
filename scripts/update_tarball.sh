#!/bin/bash

mv quarkus/dist/target/keycloak-999.0.0-SNAPSHOT.tar.gz quarkus/dist/target/keycloak-24.0.$(cat keycloak-build-number.txt).tar.gz