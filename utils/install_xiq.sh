CLUSTER_NAME=${CLUSTER_NAME:="xca-sychen"}
GDC_SERVER=${GDC_SERVER:="us.extremecloudiq.com"}
LOGIN_URL=${GDC_SHARD:="https://extremecloudiq.com"}
XIQ_VERSION=${XIQ_VERSION:="20.9.30.14"}
RDC_CUSTOMER_DOMAIN={RDC_CUSTOMER_DOMAIN:="qa.xcloudiq.com"}

NAMESPACE=xiq
DEFAULT_CHART_VERSION=3.1.0
rancher_install(){
	local CHART_NAME=$1
	local RELEASE_NAME=$2
	local CHART_VERSION=$3
	local RELEASE_NAME=${RELEASE_NAME:="$1"}
	local APP_NAME="hr-${RELEASE_NAME}"
	local CHART_VERSION=${CHART_VERSION:="$DEFAULT_CHART_VERSION"}
	rancher app install \
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
	--set acctServer=${GDC_SERVER} \
	--set loginUrl=${LOGIN_URL} \
	--set domainZone=${RDC_CUSTOMER_DOMAIN} \
    --set hmVersion=${XIQ_VERSION} \
    --set rdcName=${CLUSTER_NAME} \
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

is_middleware_ready(){
		sleep 120
}
is_middleware_ready

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

