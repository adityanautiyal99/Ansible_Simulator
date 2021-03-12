#!/bin/sh
service () {
    echo "$choice $pkg"
    if [ $choice = "enable" ];then
        status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>&1)"
        if [ ! $? = 0 ] || [ ! "$status" = installed ]
        then
            echo "$pkg not installed operation cannot be performed "
        else
            for HostFiles in $(cat hostlist)
            do
                echo "enabling"
                ssh $HostFiles -t -t "sudo systemctl enable $pkg"
            done
        fi
    elif [ $choice = "start" ];then
        status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>&1)"
        if [ ! $? = 0 ] || [ ! "$status" = installed ]
        then
            echo "$pkg not installed operation cannot be performed "
        else
            for HostFiles in $(cat hostlist)
            do
                echo "starting $pkg"
                ssh $HostFiles -t -t "sudo /etc/init.d/$pkg start"
            done
        fi
    elif [ $choice = "stop" ];then
        status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>&1)"
        if [ ! $? = 0 ] || [ ! "$status" = installed ]
        then
            echo "$1 not installed operation cannot be performed "
        else
            for HostFiles in $(cat hostlist)
            do
                echo "stoping $pkg"
                ssh $HostFiles -t -t "sudo /etc/init.d/$pkg stop"
            done
        fi
    elif [ $choice = "restart" ];then
        status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>&1)"
        if [ ! $? = 0 ] || [ ! "$status" = installed ]
        then
            echo "$pkg not installed operation cannot be performed "
        else
            for HostFiles in $(cat hostlist)
            do
                echo "restarting $pkg"
                ssh $HostFiles -t -t "sudo /etc/init.d/$pkg restart"
            done
        fi
    elif [ $choice = "reload" ];then
        status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>&1)"
        if [ ! $? = 0 ] || [ ! "$status" = installed ]
        then
            echo "$pkg not installed operation cannot be performed "
        else
            for HostFiles in $(cat hostlist)
            do
                echo "reloading $pkg"
                ssh $HostFiles -t -t "sudo /etc/init.d/$pkg reload"
            done
        fi
    else
        echo "Invalid Argument"
fi
}
