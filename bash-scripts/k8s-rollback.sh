#!/bin/bash
deployment_name="my-deployment"
kubectl rollout undo deployment/$deployment_name
echo "Rollback performed for deployment: $deployment_name."
