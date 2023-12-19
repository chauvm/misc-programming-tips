## Spin up a pod for testing
`kubectl run -i --tty --rm --image ubuntu $YOUR_POD_NAME -n $NAMESPACE -- /bin/bash`

## Exec into a running pod
`kubectl exec --stdin --tty $POD_NAME -n $NAMESPACE -- /bin/bash`

## Refresh a K8s secret to sync with ASM
`kubectl annotate externalsecrets.external-secrets.io $SECRET_NAME -n $NAMESPACE force-sync=$(date +%s) --overwrite`

## Debug a node
`kubectl debug node/mynode -it --image=ubuntu`

https://kubernetes.io/docs/tasks/debug/debug-cluster/kubectl-node-debug/
