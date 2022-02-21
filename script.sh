#!/data/data/com.termux/files/usr/bin/bash

echo "" > hosts_filtered.txt
while read d || [[ -n $d ]]; do
  ip=$(curl -s -w "%{http_code}\n" -o /dev/null $d)
  ipu=$(curl -v --silent $d 2>&1 | grep Server:)
  ipa=$(curl -v -L --silent $d 2>&1 | grep HTTP/)
  if [ -n "$ip" ]; then
    echo "[+] '$d' => $ip    $ipu"
    echo "$ip  $ipa   $d   $ipu" >> hosts_filtered.txt
  else
    echo "[!] '$d' => [RESOLVE ERROR]"
  fi
done < hosts.txt
