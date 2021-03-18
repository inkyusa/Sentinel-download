#!/bin/bash

helpFunction()
{
   echo "-w [dir path to store data]"
   exit 1
}

usageFunction()
{
   echo "============================================================="
   echo "Usage:"
   echo "./download_sentinel2_multiple_locations.sh -w ./dataset -f locations.csv"
   echo "-w dir to store data"
   echo "-f csv_file that contains (lat, log) location per row"
   echo "============================================================="
}

usageFunction

while getopts "w:f:" opt
do
   case "$opt" in
      w ) w="$OPTARG" ;;
      f ) f="$OPTARG" ;;
      ? ) helpFunction ;;
   esac
done
echo $f
i=0
while IFS=, read -r lat lon
do
    test $i -eq 0 && ((i=i+1)) && continue
    echo "lat = $lat, lon = $lon"
    python Sentinel_download.py --lat $lat --lon $lon -a apihub.txt -m 5 -d 20210301 -f 20210312 -s S2 -w "$w"
done < $f