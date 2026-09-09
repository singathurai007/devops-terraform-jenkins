#!/bin/bash

dnf update -y

dnf install -y docker

systemctl start docker
systemctl enable docker

usermod -aG docker ec2-user

docker run -d \
  --name devops-app \
  -p 80:80 \
  nginx:latest