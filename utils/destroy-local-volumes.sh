DISK_MOUNT_POINT=${DISK_MOUNT_POINT:="/persistdata"}

destroy_pvs(){
    PV_BASE=${DISK_MOUNT_POINT}/$1
    test -d ${PV_BASE} || return
    for dir in `ls -A ${PV_BASE}`; do 
        umount ${PV_BASE}/${dir}
        /bin/rm -rf ${PV_BASE}
    done
}


destroy_pvs hm-elastic
destroy_pvs ple-elastic
destroy_pvs postgresql
destroy_pvs default-redis-cluster
 