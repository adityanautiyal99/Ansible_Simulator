#!/bin/bash
# package module for installing, removing , updating packages.
package() {
    if [ $option == "install" ];then
        status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>&1)"
        if [ ! $? = 0 ] || [ ! "$status" = installed ]
        then
            for HostFiles in $(cat hostlist)
            do
                echo "Installing $pkg"
                ssh $HostFiles -t -t "sudo apt install $pkg"
            done
        else
            echo "$pkg already installed"
        fi
    elif [ "$option" = "update" ]
    then
        for HostFiles in $(cat hostlist)
        do
            echo "echo Updating packages"
            ssh $HostFiles -t -t "sudo apt-get update"
        done
    elif [ "$option" = "remove" ]
    then
        status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>&1)"
        if [ ! $? = 0 ] || [ ! "$status" = installed ]
        then
            for HostFiles in $(cat hostlist)
            do
                echo "removing Package"
                ssh $HostFiles -t -t "sudo apt remove $pkg"
        done
        else
           echo "Package does'nt exists, cannot remove"
        fi
    else
        echo "Invalid Argument"
    fi    
}

