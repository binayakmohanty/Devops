#!/bin/bash

pyear=$(date +'%Y')
pmonth=`date +'%m'`
echo "Year = $pyear"
echo "Month = $pmonth"

read -r check < <(expr $pmonth % 3)
#check= $((expr $pmonth % 3))
#check= $((expr 7 % 3))
echo "Check = $check"
if [ $check != 0 ]
  then
    echo "then $check"
    read -r pquarter < <(expr $pmonth / 3 + 1)
  else
    echo "else $check"
    read -r pquarter < <(expr $pmonth / 3)
fi

# while [ $check == $zero ]
# do
   # echo $a
   # a=`expr $a + 1`
# done

echo "Quarter = $pquarter"
echo "Month = $pmonth"     

curTag=`git describe --tags $(git rev-list --tags --max-count=1)` 
echo "$curTag"
upcurTag="${curTag:1}"
echo "$upcurTag"

IFS='.' #setting space as delimiter  
read -ra ADDR <<<"$upcurTag" #reading str as an array as tokens separated by IFS  
  
tmajor=${ADDR[0]}
tminor=${ADDR[1]}
tpatch=${ADDR[2]}

echo ${tmajor}
echo ${tminor}
echo ${tpatch}
