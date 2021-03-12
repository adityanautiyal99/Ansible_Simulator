#!/bin/bash
teplateEngine() {
if [ $3 = "" ];then
    echo "Invalid argument"
else
    trainer=$(echo $arg1 | cut -d "=" -f2)
    course=$(echo $arg2 | cut -d "=" -f2)
    sed -i "s/{uname}/${trainer}/g" $destination
    sed -i "s/{topic}/${course}/g" $destination
fi
}
