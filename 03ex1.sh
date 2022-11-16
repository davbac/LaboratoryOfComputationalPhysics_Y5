#!/bin/bash
if [ ! -d students ]; then  mkdir students;fi
cd students

if [ ! -f students.csv ] ; then
wget https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv
mv LCP_22-23_students.csv students.csv
fi



touch pod_students.csv
touch phys_students.csv

grep "PoD" students.csv > pod_students.csv
grep "Phys" students.csv > phys_students.csv



highcount=-1
highlett=" "
for i in {A..Z}; do
 count=$( grep -c "^$i" students.csv);
 echo "$i: $count";
 if [ $count -gt $highcount ]; then
  highcount=$count
  highlett=$i
 fi
done

echo "Letter with highest surname count is $highlett"



for i in $(cat students.csv | tr ", " "," | tr " ," "," | grep -v "Family" | grep -n ".*" ); do
 #echo $i
 if [  $(echo $i | grep "^[0-9]") ] ; then
  num=$( echo $i | sed "s/:.*$/ /" )
  #echo $num
  j=$(( $num % 18 ))
  echo $( echo $i | sed "s/^.*:/ /" ) >> "students_$j.csv"
 fi
done


