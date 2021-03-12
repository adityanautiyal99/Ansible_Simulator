#! /bin/bash
edit() {
    echo -e "$host" >> hostlist
    if [ -f "hostlist" ];then
        for HostFiles in $(cat hostlist)
            do 
                ssh $HostFiles -t -t "echo "$datatoadd" >> $destination"
            done
    fi
}