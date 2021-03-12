#!/bin/bash
usermodule(){
    echo "$action $user"
    if [ "$action" == "create" ];then
    for hostline in $(cat hostlist)
    do 
        ssh $hostline -t -t "sudo useradd $user"
    done
    elif [ "$action" == "delete" ];then
            for hostline in $(cat hostlist)
            do 
                ssh $hostline -t -t "sudo deluser $user"
            done
    elif [ "$action" == "modify" ];then
            if [ -n "$shell" ]
            then
                for hostline in $(cat hostlist)
                do 
                    ssh $hostline -t -t "sudo usermod -s $shell $user"
                done
            fi
    else
        echo "No such Inventory file exist."
        exit 0
    fi
}