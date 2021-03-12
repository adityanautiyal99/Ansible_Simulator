#!/bin/bash
# creating inventory file.
filename=$1
user=$2
hostname=$3
group=$4
createInventory(){
    if [ -f "$filename" ]
    then
        if [ -s "$filename" ]
        then
            redundant=$(awk -F: -v g=$group '$1==g {print $2,$3}' $filename | grep -w "$user $hostname" | wc -l)
            if [ $redundant -gt 0 ]
            then
                echo "$user@$hostname already exist in $group."
                exit 0
            else
                echo "content added successfully file"
                echo "$group:$user:$hostname" >> $filename
                echo "$user@$hostname" >> hostlist
            fi
        else
            echo "$group:$user:$hostname" >> $filename
        fi
    fi
}
createInventory $filename $user $hostname $group