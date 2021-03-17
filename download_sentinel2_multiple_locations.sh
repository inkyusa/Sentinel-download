#!/bin/bash

get_abs_filename() {
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

helpFunction()
{
   echo "-w [dir path to store data]"
   exit 1
}


while getopts "w:" opt
do
   case "$opt" in
      w ) w="$OPTARG" ;;
      ? ) helpFunction ;;
   esac
done
#w=$(get_abs_filename "$w")
i=0
while IFS=, read -r lat lon
do
    test $i -eq 0 && ((i=i+1)) && continue
    echo "lat = $lat, lon = $lon"
    python Sentinel_download.py --lat $lat --lon $lon -a apihub.txt -m 5 -d 20210301 -f 20210312 -s S2 -w "$w"
done < locations2.csv