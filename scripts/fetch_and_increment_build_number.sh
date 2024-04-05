#!/bin/bash

gcloud storage cp gs://wellstand/keycloak-build-number.txt keycloak-build-number.txt
cp keycloak-build-number.txt keycloak-build-number-last.txt
expr `cat keycloak-build-number-last.txt` + 1 > keycloak-build-number.txt
gcloud storage cp keycloak-build-number.txt gs://wellstand/keycloak-build-number.txt