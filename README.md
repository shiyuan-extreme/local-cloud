# Local Cloud Task Items

## Prepare Local Volumes

```she
# run following command on all boxes
curl --silent https://raw.githubusercontent.com/shiyuan-extreme/local-cloud/master/utils/create-local-valumes.sh | sh 
```

# Rancher Integration Task Items

## Import Local Cloud to Rancher

[Importing Existing Clusters into Rancher](https://rancher.com/docs/rancher/v2.x/en/cluster-provisioning/imported-clusters/)

## Configure XIQ Catalog

```she
catalog name: xiqcommon
catalog URL : https://charts.xcloudiq.com/common	
```

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

## Installing Helm Operator

```she
rancher app install --namespace flux helm-operator helm-operator 
```

## Installing Local Volume Static Provisioner

```she
rancher app install --namespace local-volume local-static-provisioner local-static-provisioner
```

## Installing XIQ Service

### Option 1: Use Rancher Cli

#### Run Cli Command to install XIQ Service

```she
curl --silent https://raw.githubusercontent.com/shiyuan-extreme/local-cloud/master/utils/install_xiq.sh | \
	CLUSTER_NAME=xca-sychen \
	GDC_SERVER=us.extremecloudiq.com \
	LOGIN_URL=https://extremecloudiq.com \
	XIQ_VERSION=20.9.30.14 \
	RDC_CUSTOMER_DOMAIN=qa.xcloudiq.com sh 
```

### Option 2 - Use Pipeline

#### Setup Pipeline

#### Execute Pipeline

# Upgrade Service

```shell
rancher catalog refresh xiqcommon 

```





