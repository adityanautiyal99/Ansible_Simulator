#!/bin/bash
copyMod(){
    hostip=$(hostname -I)
    echo -e "\nTransfering file from $senderpath of $from to $receiverpath of $destination"
    if [ "$hostip" == *"$from"* ]
    then
        scp $senderpath $destination:$receiverpath && echo -e "copied"
    elif [ "$hostip" == *"$destination"* ]
    then
        scp $from:$senderpath $receiverpath && echo -e "copied"
    else
        scp $from:$senderpath $destination:$receiverpath && echo -e "copied"
    fi
    if [ -n "$packageinstalled" ]
    then
        echo -e "Unsuccessful"
    fi
    unset packageinstalled
}

#172.18.42.223