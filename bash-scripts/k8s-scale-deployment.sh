#!/bin/bash
deployment_name="my-deployment"
replicas=3
kubectl scale deployment $deployment_name --replicas=$replicas
echo "Scaled $deployment_name to $replicas replicas.