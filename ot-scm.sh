#!/bin/bash
. ./create-inven.sh 
. ./user.sh
. ./fileMod.sh
. ./package.sh
. ./service.sh
. ./edit.sh
. ./teplateEngine.sh
. ./copymod.sh
for argument in $@
do
    case $argument in
    user)
        serv=user
        action=$2
        user=$3
        s=$4
        shell=$5
        ;;
    service)
        serv=service
        shift
        choice=$1
        shift
        pkg=$1
        ;;
    need_help)
        serv=need_help
        ;;
    package)
        serv=package
        shift
        option=$1
        pkg=$2
        ;;
    file)
        serv=file
        shift
        state=$(echo $1 | cut -d "=" -f2)
        path=$(echo $2 | cut -d "=" -f2)
        User=$(echo $3 | cut -d "=" -f2)
        group=$(echo $4 | cut -d "=" -f2)
        src=$(echo $5 | cut -d "=" -f2)
        file=$(echo $path | awk -F/ '{print $NF}')
        file1=$(echo $src | awk -F/ '{print $NF}')
        ;;
    edit)
        serv=edit
        shift
        datatoadd=$1
        destination=$2
        host=$3
        ;;
    template)
        serv=template
        shift
        pathtotemplate=$1    
        destination=$2
        arg1=$3
        arg2=$4
        ;;
    copy)
        serv=copy
        shift
        from=$1
        senderpath=$2
        receiverpath=$3
        destination=$4
        ;;
    esac
done

function need_help(){
    echo "1. User Module

Using this module we can create a user, delete a user and modify it.
option:-
create- create user
delete- delete user
modify- modify user

usage:-
example:
./ot-scm user create aditya -s /bin/bash
./ot-scm user delete aditya
./ot-scm user modify aditya -s /bin/nologin
replace argument accoring to your requirements


2. File Module 

This module will be used to create, delete a file and directory, symbolic link.
Format:- bash ot-scm.sh file  state=<option> path=<path_of_file>
option:-
touch- To create a new file
absent- To delete a file/directory
directory- To create a directory
link- To create a soft link

Usage:-
example:-
./ot-scm file state=touch path=/opt/aditya owner=prashant group=adm
./ot-scm file state=absent path=/opt/aditya owner=prashant group=adm
./ot-scm file state=directory path=/opt/aditya 
./ot-scm file state=link path=/opt/aditya src=/home/opstree/new
./ot-scm file state=absent path=/opt/aditya 
replace argument accoring to your requirements

3. Package Module

This module will be used to install packages in remote instance.
usage bash ot-scm.sh package  <type> <package_name>
option:-
install- To install a package
update- To update a package
remove- To remove a package

usage:-
example:-
./ot-scm package install java-default
./ot-scm packge update
./ot-scm package remove nginx

4. Service Module

This module will be used to restart, start and stop a service.
usage bash ot-scm.sh service  <type> <service_name>
option:-
enable- To start a service on boot
start- To stop a service
stop- To stop a service
restart- To restart a service

Usage:-
./ot-scm service  enable nginx
./ot-scm service start nginx
./ot-scm service stop nginx
./ot-scm service restart nginx

5. Copy Module

This tool will be used to copy a file.
Format:- bash ot-scm.sh local-src/remote-src <src path> local-src/remote-src <src path> 

Usage:
example:-
./ot-scm copy local-src pathofFile remote-src path ofFile
./ot-scm copy remote-src pathofFile remote-src path ofFile
./ot-scm copy remote-src pathofFile local-src path ofFile

6. Template Module

This module will be used as a template to modify the file at run time
Format:- bash ot-scm.sh template  <template_path> remote-src <remote_src_dest> vars:<var1=value1,var2=value2...>

Usage:-
example:-
./ot-scm template pathtotemplatefile remote-src destination

7. Edit Module

This module will be used to add data to existing file in server
Format:- bash ot-scm.sh '<datatoadd>' remote-src <destination> 

Usage:-
example:-
./ot-scm edit "datatoadd" remote-src destination
    "
}

if [ "$serv" == "service" ];then
    service $choice $pkg
elif [ "$serv" == "package" ];then
    package $option $pkg
elif [ "$serv" == "file" ];then
    fileMod $state $path $file $User $group $file1
elif [ "$serv" == "need_help" ];then
    need_help
elif [ "$serv" == "edit" ];then
    edit $datatoadd $destination 
elif [ "$serv" == "template" ];then
    teplateEngine $pathtotemplate $destination $host $arg1 $arg2
elif [ "$serv" == "user" ];then
    usermodule $action $user $s $shell
elif [ "$serv" == "copy" ];then
    copyMod $from $senderpath $receiverpath $destination
else
    echo "Not valid"    
fi
