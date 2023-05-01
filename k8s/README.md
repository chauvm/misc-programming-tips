## Refresh a K8s secret to sync with ASM
`kubectl annotate externalsecrets.external-secrets.io $SECRET_NAME -n $NAMESPACE force-sync=$(date +%s) --overwrite`
