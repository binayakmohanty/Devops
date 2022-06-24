#!/bin/bash

#pyear=$(date +'%Y')
pyear=2022
#pmonth=`date +'%m'`
pmonth=06
zero=0
echo "Year = $pyear"
echo "Month = $pmonth"

read -r check < <(expr $pmonth % 3)
echo "Check = $check"
if [ $check != 0 ]
  then
    echo "then $check"
    read -r pquarter < <(expr $pmonth / 3 + 1)
  else
    echo "else $check"
    read -r pquarter < <(expr $pmonth / 3)
fi

echo "Quarter = $pquarter"
echo "Month = $pmonth"     

git fetch origin
curTag=`git describe --tags $(git rev-list --tags --max-count=1)` 
echo "$curTag"
upcurTag="${curTag:1}"
echo "$upcurTag"

IFS='.' read -ra ADDR <<<"$upcurTag"
  
tmajor=${ADDR[0]}
tminor=${ADDR[1]}
tpatch=${ADDR[2]}

echo ${tmajor}
echo ${tminor}
echo ${tpatch}

tpatch=$((tpatch + 1))
read -r upatch < <(echo $tpatch)
echo "upatch = $upatch"

if [ $tmajor != $pyear ]
  then
    echo "tmajor = $pyear"
    read -r umajor < <(echo $pyear)
    read -r upatch < <(echo $zero)
	
  else
    echo "else $check"
    read -r umajor < <(expr $tmajor)	
fi
echo "Updated major = $umajor"
if [ $tminor != $pquarter ]
  then
    echo "then $check"
	read -r uminor < <(echo $pquarter)
	read -r upatch < <(echo $zero)
  else
    echo "else $check"
    read -r uminor < <(expr $tminor)	
fi
echo "Updated minor = $uminor"
read -r newStr < <(echo "v${umajor}.${uminor}.${upatch}")
echo "v${umajor}.${uminor}.${upatch}"
echo $newStr

