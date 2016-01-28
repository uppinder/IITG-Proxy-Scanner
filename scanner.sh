#!/bin/bash

#create text file to store working proxies
touch proxies.txt

> proxies.txt

counter=0

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
			wget -q --spider -e use_proxy=yes -e http_proxy=$http_proxy -q --tries=1 --timeout=0.1 --spider http://google.com
			
			if [ $? -eq 0 ]; then
				echo "${http_proxy:7}" >> proxies.txt
			fi

			(( counter++ ))
			percent=$((counter / 18))
			echo -ne "Scanning... ${percent}% done\r"
			
		done
	done
done

echo "Done. Check proxies.txt."
