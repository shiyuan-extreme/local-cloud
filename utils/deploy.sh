CLUSTER=${CLUSTER:=xca-sychen}

WRONG_CLUSTER=1
FAILEDCMD=2

log() {
    echo "`date '+%F %T'` $@"
}

must_exec(){
    ouput=`eval $@`
    if [ $? -eq 0 ]; then
        log "output"
    else
        log "failed: $output"
        exit $FAILEDCMD
    fi
}

log "rancher cli must logged in"
output=`must_exec rancher context  current`
if ! echo  $output | grep -q $CLUSTER; then
    log "rancher context cluster must be $CLUSTER"
    log "please switch contxt, tips: rancher context switch"
    exit $WRONG_CLUSTER
fi

log "adding catalog: xiqpub"
if ! rancher  catalog list  | grep -q xiqpub; then
    must_exec rancher  catalog  add --helm-version v3 xiqpub https://charts.xcloudiq.com/public/ 
fi


log "creating namespace: xiq"
