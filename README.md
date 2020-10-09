# Local Cloud Task Items

## Prepare Local Volumes

```she
# run following command on all boxes
curl https://raw.githubusercontent.com/shiyuan-extreme/local-cloud/master/utils/create-local-valumes.sh | sh 
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
CLUSTER_NAME=${CLUSTER_NAME:="xca-test"}
hmVersion=${hmVersion:="20.9.30.14"}

NAMESPACE=xiq
DEFAULT_CHART_VERSION=3.1.0

rancher_install(){
	local CHART_NAME=$1
	local RELEASE_NAME=$2
	local CHART_VERSION=$3
	local RELEASE_NAME=${RELEASE_NAME:="$1"}
	local APP_NAME="hr-${RELEASE_NAME}"
	local CHART_VERSION=${CHART_VERSION:="$DEFAULT_CHART_VERSION"}
	echo rancher app install \
		--set chart.version=${CHART_VERSION} \
		--set chart.name=${CHART_NAME}   \
		--set releaseName=${RELEASE_NAME} \
		--namespace ${NAMESPACE}  \
		helm-release ${APP_NAME}
}


# deploy GCR pulling secret
rancher kubectl -n ${NAMESPACE} apply -f https://raw.githubusercontent.com/shiyuan-extreme/local-cloud/master/miscs/gcr-pull-secret.yaml

# create pvc for file server 
rancher kubectl -n $NAMESPACE -f https://raw.githubusercontent.com/shiyuan-extreme/local-cloud/master/miscs/efs-fileserver-pvc.yaml

# install settings
rancher app install \
	--namespace $NAMESPACE \
	--set acctServer=g4xca.qa.xcloudiq.com \
	--set domainZone=qa.xcloudiq.com \
    --set hmVersion=${hmVersion} \
    --set rdcName=$CLUSTER_NAME \
    xiq-settings xiq-settings

# install mx replay
rancher_install mx-relay "" 1.1.1


# install middlewares
rancher_install	hm-postgresql-ha
rancher_install hm-ignite "" 3.1.1
rancher_install ple-ignite 
rancher_install	hm-rabbitmq 
rancher_install	monitor-rabbitmq 
rancher_install	ple-rabbitmq
rancher_install	hm-elastic
rancher_install	ple-elastic
rancher_install	default-redis-cluster
rancher_install	idmgateway


# install applications
rancher_install nginx-frontend  
rancher_install nginx-backend "" 3.3.0 
rancher_install nginx-static    
rancher_install hmweb           
rancher_install hmreport        
rancher_install xapi            
rancher_install afsweb          
rancher_install scheduler       
rancher_install idmauth         
rancher_install idmlog          
rancher_install idmcwp          
rancher_install capwapmaster    
rancher_install capwapserver capwapserver-0  
rancher_install capwapserver capwapserver-1
rancher_install taskengine teall           
rancher_install ple             
rancher_install hacr            
rancher_install wing-config     
rancher_install wing-stats      
rancher_install cloudcwp        
rancher_install notify-engine      

```

### Option 2 - Use Pipeline

#### Setup Pipeline

#### Execute Pipeline

# Upgrade Service

```shell
rancher catalog refresh xiqcommon 

```





