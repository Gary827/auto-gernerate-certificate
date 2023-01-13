#/bin/bash

# $1是取得對應取得傳給腳本的第1個參數
domain=$1
commonname=$domain

# my company details
# read company-details.txt and get word by order
country=$(cat ./company-details.txt | cut -d " " -f 1)
state=$(cat ./company-details.txt | cut -d " " -f 2)
locality=$(cat ./company-details.txt | cut -d " " -f 3)
organization=$(cat ./company-details.txt | cut -d " " -f 4)
organizationalunit=$(cat ./company-details.txt | cut -d " " -f 5)
email=$(cat ./company-details.txt | cut -d " " -f 6)

-z, if variable is empty string, then return True
if [ -z "$domain"]
then
    echo "Argument not present"
    echo "Usage $0 [common name]"
    exit 99

else
    # if Private key not exist，generate it
    key = find . -type f -name "*.key"
    if [ -z $key ]
    then
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
    # if Private key exist，use same Private key to generate CSR
    else
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
fi