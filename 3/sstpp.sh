#!/bin/bash
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
function add-sstp(){
#!/bin/bash
MYIP=$(wget -qO- ifconfig.co);
echo "Checking VPS"
clear
IP=$(wget -qO- ifconfig.co);
sstp="$(cat ~/log-install.txt | grep -i SSTP | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
                 echo -e "Name : Create SSTP Account" | lolcat
		 echo -e "==========================" | lolcat
		read -rp "Usernew: " -e user
		CLIENT_EXISTS=$(grep -w $user /var/lib/premium-script/data-user-sstp | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
read -p "Password: " pass
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
cat >> /home/sstp/sstp_account <<EOF
$user * $pass *
EOF
echo -e "### $user $exp">>"/var/lib/premium-script/data-user-sstp"
clear
cat <<EOF

Name : SSTP VPN
=================================
Server IP     : $IP
Username      : $user
Password      : $pass
Port          : $sstp
Cert          : http://$IP:81/server.crt
Expired On    : $exp
=================================
EOF
}
function del-sstp(){
#!/bin/bash
MYIP=$(wget -qO- ifconfig.co);
echo "Checking VPS"
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/var/lib/premium-script/data-user-sstp")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "Name : Delete SSTP Account" | lolcat
		echo "=============================="
		echo "You have no existing clients!" | lolcat
		exit 1
	fi

	echo ""
	echo " Name : Delete SSTP Account"
	echo "==============================" | lolcat
	echo " Select the existing client you want to remove"
	echo " Press CTRL+C to return"
	echo ""
	echo " ===============================" | lolcat
	echo "     No  Expired   User"
	grep -E "^### " "/var/lib/premium-script/data-user-sstp" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Pilih salah satu[1]: " CLIENT_NUMBER
		else
			read -rp "Pilih salah satu [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
Client=$(grep -E "^###" /var/lib/premium-script/data-user-sstp | cut -d ' ' -f 2-3 | sed -n "$CLIENT_NUMBER"p)
user=$(grep -E "^###" /var/lib/premium-script/data-user-sstp | cut -d ' ' -f 2 | sed -n "$CLIENT_NUMBER"p)
exp=$(grep -E "^###" /var/lib/premium-script/data-user-sstp | cut -d ' ' -f 3 | sed -n "$CLIENT_NUMBER"p)
sed -i "/^### $user $exp/d" /var/lib/premium-script/data-user-sstp
sed -i '/^'"$user"'/d' /home/sstp/sstp_account
clear
echo " SSTP Account Has Been Successfully Deleted" | lolcat
echo " =========================="
echo " Client Name : $user"
echo " Expired On  : $exp"
echo " =========================="
}
function renew-sstp(){
#!/bin/bash
MYIP=$(wget -qO- ifconfig.co);
echo "Checking VPS"
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/var/lib/premium-script/data-user-sstp")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "Name : Renew SSTP"
		echo "===============================" | lolcat
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo " Name : Renew SSTP"
	echo "===============================" | lolcat
	echo " Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo ""
	echo -e "===============================" | lolcat
	grep -E "^### " "/var/lib/premium-script/data-user-sstp" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
read -p "Expired (days): " masaaktif
user=$(grep -E "^### " "/var/lib/premium-script/data-user-sstp" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/var/lib/premium-script/data-user-sstp" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "s/### $user $exp/### $user $exp4/g" /var/lib/premium-script/data-user-sstp
clear
echo ""
echo " SSTP Account Has Been Successfully Renewed" 
echo " ==========================" | lolcat
echo " Client Name : $user"
echo " Expired On  : $exp4"
echo " ==========================" | lolcat
}
function cek-sstp(){
#!/bin/bash
MYIP=$(wget -qO- ifconfig.co);
echo "Checking VPS"
clear
accel-cmd show sessions
echo ""

}
clear
joker
echo -e "\E[47;1;35m   \e[46;1;35m   \e[45;1;35m   \E[43;1;35m   \e[42;1;35m   \e[41;1;35m   \e[40;1;35m  \033[1;39m SSR\033[1;32m  \E[40;1;35m   \e[41;1;35m   \e[42;1;35m   \E[43;1;35m   \e[44;1;35m   \e[45;1;35m   \e[46;1;35m\e[47;1;35m   \e[48;1;35m \e[49;1;35m  \E[0m"
echo -e ""
echo -e "
$bd 1$bl]\e[m$bd  Create Account SSTP
$bd 2$bl]\e[m$bd  Delete SSTP Account
$bd 3$bl]\e[m$bd  Renew SSTP Account
$bd 4$bl]\e[m$bd  Check User Login SSTP"| lolcat
echo -e ""
echo -e "\e[1;32m══════════════════════════════════════════\e[m" | lolcat
echo -e " x)   MENU  \e[m"  | lolcat
echo -e "\e[1;32m══════════════════════════════════════════\e[m" | lolcat
echo -e ""
read -p "     Please Input Number  [1-4 or x] :  "  ssssr
echo -e ""
case $ssssr in
1)
add-sstp
;;
2)
del-sstp
;;
3)
renew-sstp
;;
4)
cek-sstp
;;
x)
menu
;;
*)
echo "Please enter an correct number"
;;
esac
