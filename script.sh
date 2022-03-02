#!/data/data/com.termux/files/usr/bin/bash

echo "" > hosts_filtered.txt
while read d || [[ -n $d ]]; do
  ip=$(curl -s -w "%{http_code}\n" -o /dev/null $d|head -1)
  ipu=$(curl -v --silent $d 2>&1 | grep -i server: | cut --delimiter=" " -f 3 | cut --delimiter="^" -f 1 |head -1)
  ipua=$(curl -v --silent $d 2>&1 | grep -i via: | cut --delimiter="^" -f 1 |head -1)
  ipus=$(curl -v --silent $d 2>&1 | grep -i x-cdn: | cut --delimiter="^" -f 1 |head -1)
  iput=$(curl -v --silent $d 2>&1 | grep -i x-cache: | cut --delimiter="^" -f 1 |head -1)
  ipum=$(curl -v --silent $d 2>&1 | grep -i x-id: | cut --delimiter="^" -f 1 |head -1)
  ipas=$(curl -L -v --silent $d 2>&1 | grep "200 OK" | cut --delimiter=" " -f 2,3,4|head -1)
  if [ -n "$ip" ]; then
    echo "[+] '$d' => $ip    $ipu"
    echo "$ip	$d	$ipu	$ipas  $ipua  $ipus  $iput  $ipum " >> hosts_filtered.txt
  else
    echo "[!] '$d' => [RESOLVE ERROR]"
  fi
done < hosts.txt
tr -d '\15\32' < hosts_filtered.txt > output.txt
rm hosts_filtered.txt

read -p "Do you wish to save hosts onto your main storage (y / n)? " yn
    if [[ "$yn" =~ 'y' ]]; then continue; fi
    if [[ "$yn" =~ 'n' ]]; then exit; fi

cp output.txt /sdcard/output.txt
