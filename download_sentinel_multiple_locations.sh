#!/bin/bash

i=0
while IFS=, read -r lat lon
do
    test $i -eq 0 && ((i=i+1)) && continue
    echo "lat = $lat, lon = $lon"
    python Sentinel_download.py --lat $lat --lon $lon -a apihub.txt -m 10 -d 20210301 -f 20210312 -s S2
done < locations.csv