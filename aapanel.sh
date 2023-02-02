#! /bin/bash
# By Aaron
# https://github.com/Github-Aiko/aaPanel

red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
purple(){
    echo -e "\033[35m\033[01m$1\033[0m"
}

function aapanel-install(){
wget -O "/root/aapanel-install.sh" "http://www.aapanel.com/script/install_6.0_en.sh"
red "Installing the original aapanel panel from the official website."
bash "/root/aapanel-install.sh"
}


function panel-happy(){
red "Please manually open the software store once before executing"
sed -i 's|"endtime": -1|"endtime": 999999999999|g' /www/server/panel/data/plugin.json
sed -i 's|"pro": -1|"pro": 0|g' /www/server/panel/data/plugin.json
chattr +i /www/server/panel/data/plugin.json
chattr -i /www/server/panel/data/repair.json
rm /www/server/panel/data/repair.json
cd /www/server/panel/data
wget https://ghproxy.com/https://raw.githubusercontent.com/Github-Aiko/aaPanel/main/resource/repair.json
chattr +i /www/server/panel/data/repair.json
red "cracked successfully."
}

function uninstall(){
wget -O "/root/bt-uninstall.sh" "http://download.bt.cn/install/bt-uninstall.sh"
bash "/root/bt-uninstall.sh"
red "Panel uninstalled successfully."
}

function log(){
echo "" > /www/server/panel/script/site_task.py
chattr +i /www/server/panel/script/site_task.py
rm -rf /www/server/panel/logs/request/*
chattr +i -R /www/server/panel/logs/request
}



function start_menu(){
    clear
    purple " Thank you for using the aaPanel tool."
    purple " https://github.com/Github-Aiko/aaPanel"
    yellow " ————————————————————————————————————————————————"
    green " 1. Install aaPanel on CentOS/Debian/Ubuntu"
    yellow " ————————————————————————————————————————————————"
    green " 2. Aapanel Pro"
    green " 3. Delete log files, lock file write permissions"
    yellow " ————————————————————————————————————————————————"
    green " 4. Uninstall the aaPanel panel"
    green " 5. Cleanup script produces junk files"
    green " 0. Exit"

    echo
    read -p "Please key in numbers:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           aapanel-install
        ;;
        2 )
           panel-happy
        ;;
        3 )
           log
        ;;
        4 )
           uninstall
        ;;
        5 )
           clean-up-trash
        ;;
        0 )
            exit 1
        ;;
        * )
            clear
            red "Please enter the correct number!"
            start_menu
        ;;
    esac
}
start_menu "first"
