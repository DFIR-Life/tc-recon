#!/bin/bash

#setup
DOMAIN=$1
DIRECTORY=$1_recon


TODAY=$(date) 
echo "This scan was created on $TODAY"

echo "Creating directory $DIRECTORY" 
mkdir $DIRECTORY 

case $2 in 
	nmap)
	nmap $DOMAIN -A -oA $DIRECTORY/${DOMAIN}_nmap 
	echo "The results of nmap scan are stored in $DIRECTORY/nmap."
	;;
	dir)
	dirsearch -u $DOMAIN  -e php -o /home/kali/scripts/$DIRECTORY/${DOMAIN}_dirsearch --format=plain
	echo "The results of dirsearch scan are stored in ${DIRECTORY}_dirsearch."
	;;
	crt)
	curl -o $DIRECTORY/${DOMAIN}_crt "https://crt.sh/?q=$DOMAIN&output=json"
	echo "The results of cert parsing is stored in $DIRECTORY/${DOMAIN}_crt."
	;;
	who)
    whois $DOMAIN  >>  /home/kali/scripts/$DIRECTORY/${DOMAIN}_misc
	nslookup $DOMAIN  >>  /home/kali/scripts/$DIRECTORY/${DOMAIN}_misc
	wget $DOMAIN/robots.txt --no-check-certificate   >>  /home/kali/scripts/$DIRECTORY/${DOMAIN}_robots
	echo "The results of misc tools are stored in $DIRECTORY/"
	;;
	*)
	nmap $DOMAIN -A -oA $DIRECTORY/${DOMAIN}_nmap 
    echo "The results of nmap scan are stored in $DIRECTORY/nmap."
	dirsearch -u $DOMAIN  -e php -o /home/kali/scripts/$DIRECTORY/${DOMAIN}_dirsearch --format=plain
    echo "The results of dirsearch scan are stored in ${DIRECTORY}_dirsearch."
	curl "https://crt.sh/?q=$DOMAIN&output=json" -o $DIRECTORY/${DOMAIN}_crt 
    echo "The results of cert parsing is stored in $DIRECTORY/${DOMAIN}_crt."
	whois $DOMAIN  >>  /home/kali/scripts/$DIRECTORY/${DOMAIN}_misc
	nslookup $DOMAIN  >>  /home/kali/scripts/$DIRECTORY/${DOMAIN}_misc
    wget $DOMAIN/robots.txt --no-check-certificate   >>  /home/kali/scripts/$DIRECTORY/${DOMAIN}_robots
    echo "The results of misc tools are stored in $DIRECTORY/"
	;;
esac



