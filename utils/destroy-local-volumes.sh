DISK_MOUNT_POINT=${DISK_MOUNT_POINT:="/persistdata"}

destroy_pvs(){
    PV_BASE=${DISK_MOUNT_POINT}/$1
    test -d ${PV_BASE} || return
    for dir in `ls -A ${PV_BASE}`; do 
        umount ${PV_BASE}/${dir}
        sleep 3
        /bin/rm -rfv ${PV_BASE}
        echo "removed ${PV_BASE}/${dir}"
    done
}


destroy_pvs hm-elastic
destroy_pvs ple-elastic
destroy_pvs postgresql
destroy_pvs default-redis-cluster

# cleanup fstab
sed -i '/bind/d' /etc/fstab
