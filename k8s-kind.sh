#!/bin/bash

kind create cluster --config=- <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
runtimeConfig:
  "admissionregistration.k8s.io/v1beta1": true
  "api/beta": true
networking:
  ipFamily: ipv6
  apiServerAddress: 127.0.0.1
  apiServerPort: 6443
name: ambient
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: ClusterConfiguration
    apiServer:
        extraArgs:
          feature-gates: "ValidatingAdmissionPolicy=true"
          enable-admission-plugins: NodeRestriction,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ValidatingAdmissionPolicy
  image: kindest/node:v1.29.0@sha256:eaa1450915475849a73a9227b8f201df25e55e268e5d619312131292e324d570
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    listenAddress: "127.0.0.1"
    protocol: TCP
EOF
