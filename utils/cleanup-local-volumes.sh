DISK_MOUNT_POINT=${DISK_MOUNT_POINT:="/persistdata"}

cleanup_pvs(){
    PV_BASE=${DISK_MOUNT_POINT}/$1
    test -d ${PV_BASE} || return
    # for dir in `ls -A ${PV_BASE}`; do 
    #     /bin/rm -rfv ${PV_BASE}/${dir}/*
    # done
    /bin/rm -rfv ${PV_BASE}/*/*
}


cleanup_pvs hm-elastic
cleanup_pvs ple-elastic
cleanup_pvs postgresql
cleanup_pvs default-redis-cluster
 