#!/bin/bash

kind create cluster --config=- <<EOF
kind: Cluster
name: test-cluster
apiVersion: kind.x-k8s.io/v1alpha4
featureGates:
  ValidatingAdmissionPolicy: true
name: ambient
nodes:
- role: control-plane
  image: kindest/node:v1.30.0-alpha.0.102_41890534532931@sha256:446bf1e60d4365b8b37ef832e99a8377cd41178889d86275880667e8034c89d9
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    listenAddress: "127.0.0.1"
    protocol
EOF
