#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ifconfig.co);
echo "Checking VPS"
clear
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(grep -c -E "^# BEGIN_Backup" /etc/crontab)
if [[ "$cek" = "1" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
function start() {
email=$(cat /home/email)
if [[ "$email" = "" ]]; then
echo "Please enter your email"
read -rp "Email: " -e email
cat <<EOF>>/home/email
$email
EOF
fi
cat << EOF >> /etc/crontab
# BEGIN_Backup
5 0 * * * root bckp
# END_Backup
EOF
service cron restart
sleep 1
echo " Please Wait"
clear
echo " Autobackup Has Been Started"
echo " Data Will Be Backed Up Automatically at 00:05 GMT +7"
exit 0
}
function stop() {
email=$(cat /home/email)
sed -i "/^$email/d" /home/email
sed -i "/^# BEGIN_Backup/,/^# END_Backup/d" /etc/crontab
service cron restart
sleep 1
echo " Please Wait"
clear
echo " Autobackup Has Been Stopped"
exit 0
}
clear
echo -e "\E[47;1;35m   \e[46;1;35m   \e[45;1;35m   \E[43;1;35m   \e[42;1;35m   \e[41;1;35m   \e[40;1;35m  \033[1;39m AUTO BACKUP DATA\033[1;32m  \E[40;1;35m   \e[41;1;35m   \e[42;1;35m   \E[43;1;35m   \e[44;1;35m   \e[45;1;35m   \e[46;1;35m\e[47;1;35m   \e[48;1;35m \e[49;1;35m  \E[0m"

echo -e " Status $sts"
echo -e "  1. Start Autobackup"
echo -e "  2. Stop Autobackup"
echo -e " Press CTRL+C to return"
read -rp " Please Enter The Correct Number : " -e num
if [[ "$num" = "1" ]]; then
start
elif [[ "$num" = "2" ]]; then
stop
else
clear
echo " You Entered The Wrong Number"
menu
fi
