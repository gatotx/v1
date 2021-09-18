#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
cyan='\x1b[96m'
white='\x1b[37m'
bold='\033[1m'
off='\x1b[m'

clear
joker
echo -e "\E[47;1;35m   \e[46;1;35m   \e[45;1;35m   \E[43;1;35m   \e[42;1;35m   \e[41;1;35m   \e[40;1;35m  \033[1;39m MONITOR BANDWITH\033[1;32m  \E[40;1;35m   \e[41;1;35m   \e[42;1;35m   \E[43;1;35m   \e[44;1;35m   \e[45;1;35m   \e[46;1;35m\e[47;1;35m   \e[48;1;35m \e[49;1;35m  \E[0m"
echo -e ""
echo -e "     1 =>   Lihat Total Bandwith Tersisa"
echo -e "     2 =>   Tabel Penggunaan Setiap 5 Menit"
echo -e "     3 =>   Tabel Penggunaan Setiap Jam"
echo -e "     4 =>   Tabel Penggunaan Setiap Hari"
echo -e "     5 =>   Tabel Penggunaan Setiap Bulan"
echo -e "     6 =>   Tabel Penggunaan Setiap Tahun"
echo -e "     7 =>   Tabel Penggunaan Tertinggi"
echo -e "     8 =>   Statistik Penggunaan Setiap Jam"
echo -e "     9 =>   Lihat Penggunaan Aktif Saat Ini"
echo -e "    10 =>   Lihat Trafik Penggunaan Aktif Saat Ini [5s]"
echo -e "     x =>   Keluar"
echo -e "${off}"
echo -e "${red}======================================${off}"
echo -e "${white}"
read -p "     [#]  Masukkan Nomor :  " noo
echo -e "${off}"

case $noo in
1)
echo -e "${red}======================================${off}"
echo -e "    TOTAL BANDWITH SERVER TERSISA" | lolcat
echo -e "${red}======================================${off}"
echo -e ""

vnstat

echo -e ""
echo -e "${red}======================================${off}"
echo -e "$baris2" | lolcat
;;

2)
echo -e "${red}======================================${off}"
echo -e "  PENGGUNAAN BANDWITH SETIAP 5 MENIT" | lolcat
echo -e "${red}======================================${off}"
echo -e ""

vnstat -5

echo -e ""
echo -e "${red}======================================${off}"
echo -e "$baris2" | lolcat
;;

3)
echo -e "${red}======================================${off}"
echo -e "    PENGGUNAAN BANDWITH SETIAP JAM" | lolcat
echo -e "${red}======================================${off}"
echo -e ""

vnstat -h

echo -e ""
echo -e "${red}======================================${off}"
echo -e "$baris2" | lolcat
;;

4)
echo -e "${red}======================================${off}"
echo -e "   PENGGUNAAN BANDWITH SETIAP HARI" | lolcat
echo -e "${red}======================================${off}"
echo -e ""

vnstat -d

echo -e ""
echo -e "${red}======================================${off}"
echo -e "$baris2" | lolcat
;;

5)
echo -e "${red}======================================${off}"
echo -e "   PENGGUNAAN BANDWITH SETIAP BULAN" | lolcat
echo -e "${red}======================================${off}"
echo -e ""

vnstat -m

echo -e ""
echo -e "${red}======================================${off}"
echo -e "$baris2" | lolcat
;;

6)
echo -e "${red}======================================${off}"
echo -e "   PENGGUNAAN BANDWITH SETIAP TAHUN" | lolcat
echo -e "${red}======================================${off}"
echo -e ""

vnstat -y

echo -e ""
echo -e "${red}======================================${off}"
echo -e "$baris2" | lolcat
;;

7)
echo -e "${red}======================================${off}"
echo -e "    PENGGUNAAN BANDWITH TERTINGGI" | lolcat
echo -e "${red}======================================${off}"
echo -e ""

vnstat -t

echo -e ""
echo -e "${red}======================================${off}"
echo -e "$baris2" | lolcat
;;

8)
echo -e "${red}======================================${off}"
echo -e " GRAFIK BANDWITH TERPAKAI SETIAP JAM" | lolcat
echo -e "${red}======================================${off}"
echo -e ""

vnstat -hg

echo -e ""
echo -e "${red}======================================${off}"
echo -e "$baris2" | lolcat
;;

9)
echo -e "${red}======================================${off}"
echo -e "  LIVE PENGGUNAAN BANDWITH SAAT INI" | lolcat
echo -e "${red}======================================${off}"
echo -e " ${white}CTRL+C Untuk Berhenti!${off}"
echo -e ""

vnstat -l

echo -e ""
echo -e "${red}======================================${off}"
echo -e "$baris2" | lolcat
;;

10)
echo -e "${red}======================================${off}"
echo -e "   LIVE TRAFIK PENGGUNAAN BANDWITH " | lolcat
echo -e "${red}======================================${off}"
echo -e ""

vnstat -tr

echo -e ""
echo -e "${red}======================================${off}"
echo -e "$baris2" | lolcat
;;

x)
sleep 1
menu
;;

*)
sleep 1
echo -e "${red}Nomor Yang Anda Masukkan Salah!${off}"
bw
;;
esac
