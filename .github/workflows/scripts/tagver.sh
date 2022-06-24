#!/bin/bash

pyear=$(date +'%Y')
#pyear=2023
pmonth=`date +'%m'`
#pmonth=07
zero=0

read -r check < <(expr $pmonth % 3)

if [ $check != 0 ]
  then
    read -r pquarter < <(expr $pmonth / 3 + 1)
  else
    read -r pquarter < <(expr $pmonth / 3)
fi

git fetch origin
curTag=`git describe --tags $(git rev-list --tags --max-count=1)`
upcurTag="${curTag:1}"

IFS='.' read -ra ADDR <<<"$upcurTag"
  
tmajor=${ADDR[0]}
tminor=${ADDR[1]}
tpatch=${ADDR[2]}

tpatch=$((tpatch + 1))
read -r upatch < <(echo $tpatch)
echo "upatch = $upatch"

if [ $tmajor != $pyear ]
  then
    read -r umajor < <(echo $pyear)
    read -r upatch < <(echo $zero)
  else
    read -r umajor < <(expr $tmajor)	
fi

echo "Updated major = $umajor"

if [ $tminor != $pquarter ]
  then
	read -r uminor < <(echo $pquarter)
	read -r upatch < <(echo $zero)
  else
    read -r uminor < <(expr $tminor)	
fi

read -r newStr < <(echo "v${umajor}.${uminor}.${upatch}")
echo "v${umajor}.${uminor}.${upatch}"
echo $newStr

git tag -m "Current Tag Version applied" -a $newStr
git push origin $newStr	