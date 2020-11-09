# Local Cloud Task Items

## Setup Local Volumes

```she
# run following command on all boxes
curl --silent https://raw.githubusercontent.com/shiyuan-extreme/local-cloud/master/utils/create-local-volumes.sh | sh 
```

# Rancher Integration Task Items

## Import Local Cloud to Rancher

[Importing Existing Clusters into Rancher](https://rancher.com/docs/rancher/v2.x/en/cluster-provisioning/imported-clusters/)

## Setup Rancher Command-line Tools

### Installing rancher cli

```she
TODO
```

### Cli authentication

```shell
rancher login https://<SERVER_URL> --token <BEARER_TOKEN>
```

## Create Project

### Create project oss3.0

```shel
rancher  project create --cluster $cluster oss3.0
```

### Switch Rancher Context to Project oss3.0

```shel
rancher context switch oss3.0
# view current context 
rancher context current 
```

### Create namespace 

```she
rancher namespaces create xiq
```

## Installing XIQ Service

### Installing osscli

```she
cluster=xca-sychen
rancher kubectl -n xiq apply -f https://raw.githubusercontent.com/shiyuan-extreme/local-cloud/master/miscs/gcr-pull-secret.yaml

```

### Install XIQ Service

```she
rancher kubectl -n xiq exec -it osscli-0 -- osscli repo sy
rancher kubectl -n xiq exec -it osscli-0 -- osscli app install local-static-provisioner
rancher kubectl -n xiq exec -it osscli-0 -- osscli app -l layer=middleware install
rancher kubectl -n xiq exec -it osscli-0 -- osscli app install idmgateway
rancher kubectl -n xiq exec -it osscli-0 -- osscli app install hm-schema
rancher kubectl -n xiq exec -it osscli-0 -- osscli app -l layer=webapp install
rancher kubectl -n xiq exec -it osscli-0 -- osscli app -l layer=frontend install
```

### Option 2 - Use Pipeline

#### Setup Pipeline

#### Execute Pipeline

# Upgrade Service

```she
# update git repo
rancher kubectl -n xiq exec -it osscli-0 -- osscli repo sy

# update schema if need 
rancher kubectl -n xiq exec -it osscli-0 -- osscli app install hm-schema

# upgrade service 
rancher kubectl -n xiq exec -it osscli-0 -- osscli app upgrade hmweb
```







