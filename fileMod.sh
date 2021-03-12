#!/bin/bash
# creating file module for creating removing files and directories.
fileMod() {
    if [ $state == "touch" ]
    then
        for HostFiles in $(cat hostlist)
        do 
            echo -e "Creating File"
            ssh $HostFiles -t -t "sudo touch $path && sudo chown $User $file"
        done
    elif [ $state == "absent" ]
    then
        for HostFiles in $(cat hostlist)
        do 
            echo -e "Deleting File"
            ssh $HostFiles -t -t "rm $path"
        done
    elif [ $state == "directory" ]
    then
        for HostFiles in $(cat hostlist)
        do 
            echo -e "Creating directory"
            ssh $HostFiles -t -t "mkdir $path"
        done
    elif [ $state == "absent" ]
    then
        for HostFiles in $(cat hostlist)
        do 
            echo -e "Deleting directory"
            ssh $HostFiles -t -t "rm $path"
        done
    elif [ $state == "link" ]
    then
        for HostFiles in $(cat hostlist)
        do 
            echo -e "Creating Symbolic link"
            ssh $HostFiles -t -t "ln -s $path $file1"
            exit 0
        done
    else
         echo "Successfull"
    fi
}
