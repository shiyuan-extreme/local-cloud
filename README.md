# Local Cloud Task Items

## Setup Local Volumes

```she
# run following command on all boxes
curl --silent https://raw.githubusercontent.com/shiyuan-extreme/local-cloud/master/utils/create-local-volumes.sh | sh 
```

# Rancher Integration Task Items

## Import Local Cloud to Rancher

1. Importing Existing Clusters into Rancher](https://rancher.com/docs/rancher/v2.x/en/cluster-provisioning/imported-clusters/)

2. [Create an API Key](https://rancher.com/docs/rancher/v2.x/en/user-settings/api-keys/) Please save the token, we'll use it when install osscli in the next step. 

## Installing XIQ Service

### Installing osscli

```she
cluster=xca-sychen
osscliVersion=0.2.0
rancherServer=https://myrancher.xcloudiq.com
rancherToken=<the token created in above step>
helm upgrade --install ${cluster}-osscli https://charts.xcloudiq.com/public/osscli-${osscliVersion}.tgz \
	--set oss.cluster=${cluster} \
	--set rancherServer=${rancherServer} \
	--set rancherToken=${rancherToken} \
	--set-file gitSSHKey=<the-file-path-of-git-ssh-key>

```

### Install XIQ Service

```she
# login the osscli container
kubectl exec -it ${cluster}-osscli-0 -- bash 
# run below commands 
osscli init
osscli repo sy
osscli app install local-static-provisioner
osscli app -l layer=middleware install
osscli app install idmgateway
osscli app install hm-schema
osscli app -l layer=webapp install
osscli app -l layer=frontend install
```

# Upgrade Service

```she
# login the osscli container
kubectl exec -it ${cluster}-osscli-0 -- bash 

# update git repo
osscli repo sy

# update schema if need 
osscli app upgrade hm-schema

# upgrade services as need
osscli app upgrade hmweb
```







