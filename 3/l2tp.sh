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
function add-l2tp(){
#!/bin/bash
clear
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
PUBLIC_IP=$(wget -qO- ipv4.icanhazip.com);
else
PUBLIC_IP=$IP
fi
until [[ $VPN_USER =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
                echo "Name : Create L2TP Account"
		echo "===========================" | lolcat
		read -rp "Username: " -e VPN_USER
		CLIENT_EXISTS=$(grep -w $VPN_USER /var/lib/premium-script/data-user-l2tp | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
read -p "Password: " VPN_PASSWORD
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
clear

# Add or update VPN user
cat >> /etc/ppp/chap-secrets <<EOF
"$VPN_USER" l2tpd "$VPN_PASSWORD" *
EOF

VPN_PASSWORD_ENC=$(openssl passwd -1 "$VPN_PASSWORD")
cat >> /etc/ipsec.d/passwd <<EOF
$VPN_USER:$VPN_PASSWORD_ENC:xauth-psk
EOF

# Update file attributes
chmod 600 /etc/ppp/chap-secrets* /etc/ipsec.d/passwd*
echo -e "### $VPN_USER $exp">>"/var/lib/premium-script/data-user-l2tp"
cat <<EOF

L2TP/IPSEC PSK VPN
================================
Server IP    : $PUBLIC_IP
IPsec PSK    : myvpn
Username     : $VPN_USER
Password     : $VPN_PASSWORD
Expired ON   : $exp
=================================
EOF
}
function add-pptp(){
#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
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
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
PUBLIC_IP=$(wget -qO- ifconfig.me/ip);
else
PUBLIC_IP=$IP
fi
until [[ $VPN_USER =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
                echo "Name : Create PPTP Account"
		echo "===========================" | lolcat
		read -rp "Username: " -e VPN_USER
		CLIENT_EXISTS=$(grep -w $VPN_USER /var/lib/premium-script/data-user-pptp | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
read -p "Password: " VPN_PASSWORD
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
clear

# Add or update VPN user
cat >> /etc/ppp/chap-secrets <<EOF
"$VPN_USER" pptpd "$VPN_PASSWORD" *
EOF

# Update file attributes
chmod 600 /etc/ppp/chap-secrets*
echo -e "### $VPN_USER $exp">>"/var/lib/premium-script/data-user-pptp"
cat <<EOF

Name : PPTP VPN
================================
Server IP    : $PUBLIC_IP
Username     : $VPN_USER
Password     : $VPN_PASSWORD
Expired On   : $exp
================================
EOF
}
function del-l2tp(){
#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
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
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/var/lib/premium-script/data-user-l2tp")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "Name : Delete L2TP Account" | lolcat
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	echo ""
	echo " Name : Delete L2TP Account" | lolcat
	echo ""
	echo " Select the existing client you want to remove"
	echo " Press CTRL+C to return"
	echo ""
	echo " ===============================" | lolcat
	echo "     No  Expired   User"
	grep -E "^### " "/var/lib/premium-script/data-user-l2tp" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select One Client[1]: " CLIENT_NUMBER
		else
			read -rp "Select One Client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
	# match the selected number to a client name
	VPN_USER=$(grep -E "^### " "/var/lib/premium-script/data-user-l2tp" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
	exp=$(grep -E "^### " "/var/lib/premium-script/data-user-l2tp" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
# Delete VPN user
sed -i '/^"'"$VPN_USER"'" l2tpd/d' /etc/ppp/chap-secrets
# shellcheck disable=SC2016
sed -i '/^'"$VPN_USER"':\$1\$/d' /etc/ipsec.d/passwd
sed -i "/^### $VPN_USER $exp/d" /var/lib/premium-script/data-user-l2tp
# Update file attributes
chmod 600 /etc/ppp/chap-secrets* /etc/ipsec.d/passwd*
clear
echo " L2TP Account Has Been Successfully Deleted"
echo " ==========================" | lolcat
echo " Client Name : $VPN_USER"
echo " Expired On  : $exp"
echo " ==========================" | lolcat

}
function del-pptp(){
#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
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
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/var/lib/premium-script/data-user-pptp")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "Name : Delete PPTP Account" | lolcat
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	echo ""
	echo " Name : Delete PPTP Account" | lolcat
	echo ""
	echo " Select the existing client you want to remove"
	echo " Press CTRL+C to return"
	echo ""
	echo " ===============================" | lolcat
	echo "     No  Expired   User"
	grep -E "^### " "/var/lib/premium-script/data-user-pptp" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select One Client[1]: " CLIENT_NUMBER
		else
			read -rp "Select One Client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
	# match the selected number to a client name
	VPN_USER=$(grep -E "^### " "/var/lib/premium-script/data-user-pptp" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
	exp=$(grep -E "^### " "/var/lib/premium-script/data-user-pptp" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
# Delete VPN user
sed -i '/^"'"$VPN_USER"'" pptpd/d' /etc/ppp/chap-secrets
sed -i "/^### $VPN_USER $exp/d" /var/lib/premium-script/data-user-pptp
# Update file attributes
chmod 600 /etc/ppp/chap-secrets* /etc/ipsec.d/passwd*
clear
echo " PPTP Account Has Been Successfully Deleted"
echo " ==========================" | lolcat
echo " Client Name : $VPN_USER"
echo " Expired On  : $exp"
echo " ==========================" | lolcat
}
function cek-pptp(){
#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
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
last | grep ppp | grep still | awk '{print " ",$1," - " $3 }' > /tmp/login-db-pptp.txt;
echo " "
echo " "
echo "===========================================";
echo " "
echo " "
echo "-------------------------------------";
echo "    PPTP VPN User Login";
echo "-------------------------------------";
echo "Username   ---   IP";
echo "-------------------------------------";
cat /tmp/login-db-pptp.txt
echo " "
echo " "
echo " "
echo "===========================================";
echo " ";
}
function renew-l2tp(){
#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
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
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/var/lib/premium-script/data-user-l2tp")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "Name :  Renew L2TP" | lolcat
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "Name :  Renew L2TP" | lolcat
	echo ""
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo ""
	echo -e "===============================" | lolcat
	grep -E "^### " "/var/lib/premium-script/data-user-l2tp" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
read -p "Expired (days): " masaaktif
user=$(grep -E "^### " "/var/lib/premium-script/data-user-l2tp" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/var/lib/premium-script/data-user-l2tp" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "s/### $user $exp/### $user $exp4/g" /var/lib/premium-script/data-user-l2tp
clear
echo ""
echo " L2TP Account Has Been Successfully Renewed"
echo " ==========================" | lolcat
echo " Client Name : $user"
echo " Expired On  : $exp4"
echo " ==========================" | lolcat
}
function renew-pptp(){
#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
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
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/var/lib/premium-script/data-user-pptp")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "Name : Renew PPTP" | lolcat
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "Name : Renew PPTP" | lolcat
	echo ""
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "===============================" | lolcat
	grep -E "^### " "/var/lib/premium-script/data-user-pptp" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
read -p "Expired (days): " masaaktif
user=$(grep -E "^### " "/var/lib/premium-script/data-user-pptp" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/var/lib/premium-script/data-user-pptp" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "s/### $user $exp/### $user $exp4/g" /var/lib/premium-script/data-user-pptp
clear
echo ""
echo " PPTP Account Has Been Successfully Renewed"
echo " ==========================" | lolcat
echo " Client Name : $user"
echo " Expired On  : $exp4"
echo " ==========================" | lolcat
}
clear
joker
echo -e "\E[47;1;35m   \e[46;1;35m   \e[45;1;35m   \E[43;1;35m   \e[42;1;35m   \e[41;1;35m   \e[40;1;35m  \033[1;39m L2TP\033[1;32m  \E[40;1;35m   \e[41;1;35m   \e[42;1;35m   \E[43;1;35m   \e[44;1;35m   \e[45;1;35m   \e[46;1;35m\e[47;1;35m   \e[48;1;35m \e[49;1;35m  \E[0m"
echo -e ""
echo -e "
$bd 1$bl]\e[m$bd  Creating L2TP Account
$bd 2$bl]\e[m$bd  Create Account PPTP
$bd 3$bl]\e[m$bd  Deleting L2TP Account
$bd 4$bl]\e[m$bd  Delete PPTP Account
$bd 5$bl]\e[m$bd  Check User Login PPTP
$bd 6$bl]\e[m$bd  Renew L2TP Account
$bd 7$bl]\e[m$bd  Renew PPTP Account"| lolcat
echo -e ""
echo -e "\e[1;32m══════════════════════════════════════════\e[m" | lolcat
echo -e " x)   MENU    \e[m"   | lolcat
echo -e "\e[1;32m══════════════════════════════════════════\e[m" | lolcat
echo -e ""
read -p "     Please Input Number  [1-7 or x] :  "  l2tp
echo -e ""
case "$l2tp" in
1)
add-l2tp
;;
2)
add-pptp
;;
3)
del-l2tp
;;
4)
del-pptp
;;
5)
cek-pptp
;;
6)
renew-l2tp
;;
7)
renew-pptp
;;
x)
menu
;;
*)
echo "Please enter an correct number"
;;
esac
