#!/bin/bash

clear

git_repo=https://github.com/DogLoc/unknown-sender.git

# dependencies

# package_name:packaging:packaging_termux
dependencies[0]=git:apt:pkg
dependencies[1]=python3:apt:pkg
dependencies[2]=lolcat:gem:gem

# functions

check_dependency(){
    local IFS=':'
    read -a dependency <<< "$1"
    sleep 1
    if type -P ${dependency[0]} >/dev/null 2>&1 ; then
        echo  "✅ ${dependency[0]}"
    else
        echo  "❌ ${dependency[0]}"
        if [ $(ps -ef|grep -c com.termux ) -gt 0 ]; then 
            ${dependency[3]} install ${dependency[0]}
        else
            sudo ${dependency[1]} install ${dependency[0]}
        fi
        
    fi
}

loading() {
    sleep 1 &
    PID=$!
    i=1
    sp="/-\|"

    echo -n $1 

    while [ -d /proc/$PID ]
    do
    printf "\b${sp:i++%${#sp}:1}"
    done
    echo " "
    echo " "
}

# script start

loading 'dependencies check -'

for i in "${dependencies[@]}"; do 
    check_dependency $i
done

bash banner.sh

echo "1 : send an anonymous message"
echo "2 : update tool"
read ch

case $ch in
  1)
    clear
    python3 sms.py
    ;;
  2)
    loading 'update to last version -'
    git pull ${git_repo} > /dev/null 2>&1
    ;;
  *)
    exit 0
    ;;
esac

exit 0