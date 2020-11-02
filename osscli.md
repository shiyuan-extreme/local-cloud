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

## Configure XIQ Catalog

```she
rancher  catalog  add --helm-version v3 xiqpub https://charts.xcloudiq.com/public/ 
```

## Create Project

### Create project oss3.0

```shel
rancher  project create oss3.0
```

### Switch Rancher Context to Project oss3.0

```shel
rancher context switch
NUMBER    CLUSTER NAME   PROJECT ID              PROJECT NAME   
1         rketest        c-46dhf:p-5sjpd   System         System project created for the cluster
2         rketest        c-46dhf:p-vbcpz   Default        Default project created for the cluster
3         xca-sj         c-g5h86:p-ddrls   myproject      
4         xca-sj         c-g5h86:p-fthtn   oss3.0     
Select a Project: (enter the number of project oss3.0 )
```

### Create namespace 

```she
rancher namespaces create xiq
```

## Installing XIQ Service

### Installing osscli

```she
cluster_name=
rancher kubectl -n xiq apply -f https://raw.githubusercontent.com/shiyuan-extreme/local-cloud/master/miscs/gcr-pull-secret.yaml
rancher app install \
	--set kubeConfig=$(rancher cluster kf $cluster | base64 | tr -d "\n") \
	--set oss.cluster=$cluster  \
	--namespace=xiq \
	cattle-global-data:xiqpub-osscli  \
	osscli
```

### Install XIQ Service

```she
rancher kubectl -n xiq exec -it osscli-0 -- osscli repo sy
rancher kubectl -n xiq exec -it osscli-0 -- osscli app install local-static-provisioner
rancher kubectl -n xiq exec -it osscli-0 -- osscli app -l kind=middleware install
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







