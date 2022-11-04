#!/bin/bash

###https://www.youtube.com/watch?v=YZKP12tYofo###

USERAGENT='User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.5304.63 Safari/537.36'
ACCENCODING='Accept-Encoding: gzip, deflate'
ACCLANG='Accept-Language: en-US,en;q=0.9'

usage() {
  echo "Usage: $0 [-p PLATE NUMBER] [-s 2 CHAR STATE ABBREVIATION]"
  exit 1
}
while getopts "p:s:" flag; do
  case "${flag}" in
  p|plate)
    plate=${OPTARG}
    ;;
  s|state)
    state=${OPTARG}
    ;;
  *)
    usage
    ;;
  esac
done

[[ -z "${plate-}" ]] && echo "Missing required parameter: p|plate" && exit
[[ -z "${state-}" ]] && echo "Missing required parameter: s|state" && exit

curl -s -k -H "$USERAGENT" -H "$ACCENCODING" -H "$ACCLANG" "https://www.oreillyauto.com/vehicle/plate/$plate/$state/true" | jq
