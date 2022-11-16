#!/bin/bash
cat data.csv | tr ", " " " | tail -n+5 > data.txt

ecount=$( grep -o "[02468]*\>" data.txt | grep -c ".*" )
ocount=$( grep -o "[13579]*\>" data.txt | grep -c ".*" )

echo "count of even numbers: $ecount"
echo "count of odd numbers: $ocount"



count_lt=$( cat data.txt | awk -F"  " '{print(sqrt($1^2+$2^2+$3^2)<sqrt(3)*50,"", $0)}' | grep -c "^1" )
echo "number of lines with sqrt(x^2+y^2+z^2)<100*sqrt(3)/2: $count_lt"
count_ge=$( cat data.txt | awk -F"  " '{print(sqrt($1^2+$2^2+$3^2)<sqrt(3)*50,"", $0)}' | grep -c "^0" )
echo "number of lines with sqrt(x^2+y^2+z^2)>=100*sqrt(3)/2: $count_ge"




if [ $1 ] ; then 
 for (( i=1; i<$1+1; i++ )) ; do 
  cat data.txt | awk -F"  " '{print($1/'$i', $2/'$i', $3/'$i', $4/'$i', $5/'$i', $6/'$i')}'> data_$i.txt
 done
else echo "Usage: $0 <param>"; echo "param is the number of additional data files to be created"
fi
