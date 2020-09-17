DISK_MOUNT_POINT=${DISK_MOUNT_POINT:="/persistdata"}

create_bind_mount(){
	PV_BASE=${DISK_MOUNT_POINT}/$1
	test -d $PV_BASE || mkdir -p $PV_BASE
	PV=$(mktemp -d -p $PV_BASE data.XXXXXX)
	mount --bind $PV $PV
}

create_bind_mount hm-elastic
create_bind_mount ple-elastic
create_bind_mount postgresql
create_bind_mount default-redis-cluster
create_bind_mount default-redis-cluster
