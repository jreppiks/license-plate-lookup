#!/bin/bash

usage() {
	echo "Usage: $0 [-p PLATE NUMBER] [-s 2 CHAR STATE ABBREVIATION]" 
	exit 1
}

while getopts "p:s:" flag
do
	case "${flag}" in
		p) 
			plate=${OPTARG}
			;;
		s) 
			state=${OPTARG}
			;;
		*) 
			usage;;
	esac
done

if [ -z "$plate" ] || [ -z "$state" ]; then
	echo 'missing option' >&2
	usage
fi

curl -i -s -k -X $'GET' \
   -H $'Host: www.oreillyauto.com' -H $'Sec-Ch-Ua: \"Chromium\";v=\"107\", \"Not=A?Brand\";v=\"24\"' -H $'Sec-Ch-Ua-Mobile: ?0' -H $'Sec-Ch-Ua-Platform: \"Linux\"' -H $'Upgrade-Insecure-Requests: 1' -H $'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.5304.63 Safari/537.36' -H $'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' -H $'Sec-Fetch-Site: none' -H $'Sec-Fetch-Mode: navigate' -H $'Sec-Fetch-User: ?1' -H $'Sec-Fetch-Dest: document' -H $'Accept-Encoding: gzip, deflate' -H $'Accept-Language: en-US,en;q=0.9' -H $'Connection: close' "https://www.oreillyauto.com/vehicle/plate/$plate/$state/true" | grep plate | python -m json.tool
