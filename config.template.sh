#!/bin/bash

PICKLINEAGE=$(whoami)
PICKNAILYK=${PICKLINEAGE}

git config --global user.email "jenkins@nailyk.fr"
git config --global user.name ${PICKNAILYK}

