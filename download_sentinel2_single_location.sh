#!/bin/bash

get_abs_filename() {
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

helpFunction()
{
   echo "-w [dir path to store data]"
   exit 1
}

usageFunction()
{
   echo "==================================================="
   echo "Usage:"
   echo "./download_sentinel2_single_location.sh -a -27.1 -b 157.1 -w ./dataset"
   echo "-a Latitude"
   echo "-b Longitude"
   echo "-w dir to store data"
   echo "==================================================="
}


while getopts "w:a:b:" opt
do
   case "$opt" in
      w ) w="$OPTARG" ;;
      a ) a="$OPTARG" ;;
      b ) b="$OPTARG" ;;
      ? ) helpFunction ;;
   esac
done
lat=$a
lon=$b
usageFunction
#w=$(get_abs_filename "$w")
echo "lat = $lat, lon = $lon"
echo "Data will be saved $w"
python Sentinel_download.py --lat $lat --lon $lon -a apihub.txt -m 5 -d 20210301 -f 20210312 -s S2 -w "$w"
