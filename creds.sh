#!/bin/bash

mkdir -p /root/.ssh

sops --decrypt /opt/data/sls/awsfile.yaml | sed 's#ssh_private_key: *##' | base64 --decode >/root/.ssh/id_ed25519
sops --decrypt /opt/data/sls/authorized_keys.yaml | sed 's#keys: *##' | base64 --decode >/root/.ssh/authorized_keys

chmod 700 /root/.ssh
chmod 600 /root/.ssh/*
