
### Delete all local images given name or repo URI
```
docker rmi $(docker images --format '{{.Repository}}:{{.Tag}}' | grep 'xxx.dkr.ecr.xxx.amazonaws.com/repo-name')
```
