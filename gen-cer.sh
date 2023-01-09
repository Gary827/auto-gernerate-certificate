#/bin/bash

# $1是取得對應取得傳給腳本的第1個參數
domain=$1
commonname=$domain

# my company details
country="TW"
state="Some-State"
locality="Taipei"
organization="衛生福利部國民健康署"
organizationalunit="社區健康組"
email="garywang0827@gmail.com"

# -z 代表如果後方接空字串則為True
if [ -z "$domain"]
then
    echo "Argument not present"
    echo "Usage $0 [common name]"
    exit 99

else
    password=123456
    echo "Generating key request for $domain"

    #Generate a Private Key
    openssl genrsa -des3 -passout pass:$password -out server.key 2048

    #Create the certreq.txt
    echo "Creating CSR"
    openssl req -new -key server.key -out certreq.txt -passin pass:$password \
        -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"

    echo "---------------------------"
    echo "-----Below is your CSR-----"
    echo "---------------------------"
    echo
    cat certreq.txt

    echo "---------------------------"
    echo "-----Below is your Key-----"
    echo "---------------------------"
    echo
    cat server.key

fi