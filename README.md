pkg up -y && pkg install openssl wget -y
wget -N https://raw.githubusercontent.com/SuspectWorkers/TeScanner/main/script.sh && chmod +x script.sh && ./script.sh

In hosts.txt put your hostsnames to check
In output you see -> response code, server type , via (some cdn headers) and location if it is a redirect
