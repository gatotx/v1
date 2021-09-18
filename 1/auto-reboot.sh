#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
bl='\e[36;1m'
bd='\e[1m'
MYIP=$(wget -qO- ifconfig.co);
echo "Checking VPS"
IZIN=$( curl https://raw.githubusercontent.com/gatotx/deb/main/ipvps.conf | grep $MYIP ) >/dev/null 2>&1
if [ $MYIP = $IZIN ]; then
echo -e "${green}DITERIMA${NC}"
sleep 0.5
else
echo -e "${red}IP ANDA TIDAK DIDAFTARKAN , HUBUNGI SAYA @jo3k3r UNTUK BANTUAN${NC}"
sleep 0.5
exit
fi
clear

if [ ! -e /usr/local/bin/reboot_otomatis ]; then
echo '#!/bin/bash' > /usr/local/bin/reboot_otomatis 
echo 'tanggal=$(date +"%m-%d-%Y")' >> /usr/local/bin/reboot_otomatis 
echo 'waktu=$(date +"%T")' >> /usr/local/bin/reboot_otomatis 
echo 'echo "Server successfully rebooted on the date of $tanggal hit $waktu." >> /root/log-reboot.txt' >> /usr/local/bin/reboot_otomatis 
echo '/sbin/shutdown -r now' >> /usr/local/bin/reboot_otomatis 
chmod +x /usr/local/bin/reboot_otomatis
fi

clear
joker
echo -e "\E[47;1;35m   \e[46;1;35m   \e[45;1;35m   \E[43;1;35m   \e[42;1;35m   \e[41;1;35m   \e[40;1;35m  \033[1;39m AUTO REBOOT\033[1;32m  \E[40;1;35m   \e[41;1;35m   \e[42;1;35m   \E[43;1;35m   \e[44;1;35m   \e[45;1;35m   \e[46;1;35m\e[47;1;35m   \e[48;1;35m \e[49;1;35m  \E[0m"
echo -e ""
echo -e "
$bd 1$bl]  Auto-Reboot Setiap 1 Jam
$bd 2$bl]  Set Auto-Reboot Setiap 6 Jam
$bd 3$bl]  Set Auto-Reboot Setiap 12 Jam
$bd 4$bl]  Set Auto-Reboot Setiap 1 Hari
$bd 5$bl] bdSet Auto-Reboot Setiap 1 Minggu
$bd 6$bl] Set Auto-Reboot Setiap 1 Bulan
$bd 7$bl] Matikan Auto-Reboot
$bd 8$bl] View reboot log
$bd 9$bl] Remove reboot log
══════════════════════════════════════════════\e[m" | lolcat
echo -e "$bd Press CTRL+C to return\e[m"
read -p " Select options from (1-9):" x

if test $x -eq 1; then
echo "10 * * * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
echo "Auto-Reboot has been set every an hour."
elif test $x -eq 2; then
echo "10 */6 * * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
echo "Auto-Reboot has been successfully set every 6 hours."
elif test $x -eq 3; then
echo "10 */12 * * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
echo "Auto-Reboot has been successfully set every 12 hours."
elif test $x -eq 4; then
echo "10 0 * * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
echo "Auto-Reboot has been successfully set once a day."
elif test $x -eq 5; then
echo "10 0 */7 * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
echo "Auto-Reboot has been successfully set once a week."
elif test $x -eq 6; then
echo "10 0 1 * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
echo "Auto-Reboot has been successfully set once a month."
elif test $x -eq 7; then
rm -f /etc/cron.d/reboot_otomatis
echo "Auto-Reboot successfully TURNED OFF."
elif test $x -eq 8; then
if [ ! -e /root/log-reboot.txt ]; then
	echo "No reboot activity found"
	else 
	echo 'LOG REBOOT'
	echo "-------"
	cat /root/log-reboot.txt
fi
elif test $x -eq 9; then
echo "" > /root/log-reboot.txt
echo "Auto Reboot Log successfully deleted!" | lolcat
else
echo "Options Not Found In Menu"
exit
fi
