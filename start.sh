#!/bin/bash

clear

git_repo=https://github.com/DogLoc/unknown-sender.git

# dependencies

dependencies[0]=git:apt
dependencies[1]=python3:apt
dependencies[2]=lolcat:gem

# functions

check_dependency(){
    local IFS=':'
    read -a dependency <<< "$1"
    sleep 1
    if type -P ${dependency[0]} >/dev/null 2>&1 ; then
        echo  "✅ ${dependency[0]}"
    else
        echo  "❌ ${dependency[0]}"
        sudo ${dependency[1]} install ${dependency[0]}
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

banner() {
   
   clear
   echo -e  "     
        ██╗   ██╗███╗   ██╗██╗  ██╗███╗   ██╗ ██████╗ ██╗    ██╗███╗   ██╗
        ██║   ██║████╗  ██║██║ ██╔╝████╗  ██║██╔═══██╗██║    ██║████╗  ██║
        ██║   ██║██╔██╗ ██║█████╔╝ ██╔██╗ ██║██║   ██║██║ █╗ ██║██╔██╗ ██║
        ██║   ██║██║╚██╗██║██╔═██╗ ██║╚██╗██║██║   ██║██║███╗██║██║╚██╗██║
        ╚██████╔╝██║ ╚████║██║  ██╗██║ ╚████║╚██████╔╝╚███╔███╔╝██║ ╚████║
        ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝
                                                                        
        ███████╗███████╗███╗   ██╗██████╗ ███████╗██████╗                 
        ██╔════╝██╔════╝████╗  ██║██╔══██╗██╔════╝██╔══██╗                
        ███████╗█████╗  ██╔██╗ ██║██║  ██║█████╗  ██████╔╝                
        ╚════██║██╔══╝  ██║╚██╗██║██║  ██║██╔══╝  ██╔══██╗                
        ███████║███████╗██║ ╚████║██████╔╝███████╗██║  ██║                
        ╚══════╝╚══════╝╚═╝  ╚═══╝╚═════╝ ╚══════╝╚═╝  ╚═╝

        by : https://github.com/DogLoc
    " | lolcat
   echo " "
}

# script start

loading 'dependencies check -'

for i in "${dependencies[@]}"; do 
    check_dependency $i
done

banner

if test -e update.txt ; then
    loading 'get update -'
    git pull ${git_repo}
else
    touch update.txt
    echo "Overwriting the existing text in the file" > update.txt
fi

echo " "
read -n 1 -s -r -p "Press enter to continue"
clear

python3 sms.py

exit 0
