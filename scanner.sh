#!/bin/bash

#create text file to store working proxies
touch proxies.txt

echo "Scanning..."

#add more ports if required 
ports="3128 808 8080"
for port in $ports
do
	for i in `seq 114 117`
	do
		for j in `seq 2 150`
		do
			http_proxy="http://172.16.${i}.${j}:${port}"
			#echo "Checking ${http_proxy}"
			wget -q --spider -e use_proxy=yes -e http_proxy=$http_proxy -q --tries=1 --timeout=0.3 --spider http://google.com

			if [ $? -eq 0 ]; then
				echo "${http_proxy}" > proxies.txt
			fi
		done
	done
done

echo "Done. Check proxies.txt."
