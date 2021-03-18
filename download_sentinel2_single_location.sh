#!/bin/bash

helpFunction()
{
   usageFunction
   exit 1
}

usageFunction()
{
   echo "============================================================="
   echo "Usage:"
   echo "./download_sentinel2_single_location.sh -w ./dataset -l "12.5, 40.2""
   echo "-w dir to store data"
   echo "-l Latitude, Longitude"
   echo "!!!! -l option argument should be wrapped with " " !!!!!!" 
   echo "============================================================="
}


while getopts "w:l:" opt
do
   case "$opt" in
      w ) w="$OPTARG" ;;
      l ) l="$OPTARG" ;;
      ? ) helpFunction ;;
   esac
done

IFS=', ' read -r -a loc <<< $l
lat=${loc[0]}
lon=${loc[1]}

usageFunction

echo "lat = ${lat}, lon = ${lon}"
echo "Data will be saved $w"
python Sentinel_download.py --lat $lat --lon $lon -a apihub.txt -m 5 -d 20210301 -f 20210312 -s S2 -w "$w"


#echo "Latitude = $lat, Longitute = $lon"
#echo "Data will be saved $w"
#python Sentinel_download.py --lat $lat --lon $lon -a apihub.txt -m 5 -d 20210301 -f 20210312 -s S2 -w "$w"
